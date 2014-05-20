class Cheerup < ActiveRecord::Base
  attr_accessible :user_id, :image_url, :message, :state, :image_file

  belongs_to :user
  has_many :feedbacks

  validates :message, presence: true
  validates_length_of :message, maximum: 141 
  validates :user_id, presence: true
  validate  :only_one_of_image_url_and_image_file
  validates :state, :inclusion => {:in => ["flagged", "banned", "published"]}

  scope :bans, -> { where(state: "banned") }
  scope :flags, -> { where(state: "flagged") }
  scope :published, -> { where(state: "published") }
  
  mount_uploader :image_file, CheerupImageUploader

  after_initialize :defaults
  before_validation :clear_image_file_if_image_url_given

  def likes_count
    self.feedbacks.where(kind: "like").count
  end

  def flags_count
    self.feedbacks.where(kind: "flag").count
  end

  def defaults
    self.image_url ||= 'none'
  end

  def rating
    rating = 0

    feedbacks.each do |feedback|
      if feedback.kind == "like"
        rating += 1
      elsif feedback.kind == "flag"
        rating -= 1
      end
    end
    return rating
  end

  def tweet
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['CHEERUP_APP_TWITTER_API_KEY']
      config.consumer_secret     = ENV['CHEERUP_APP_TWITTER_API_SECRET']
      config.access_token        = user.oauth_token
      config.access_token_secret = user.oauth_secret
    end
    client.update(message)  
  end

  def calculated_image_url
    image_url.present? ? image_url : image_file_url
  end

  private
  def only_one_of_image_url_and_image_file
    errors.add :base, "you can only include an image or an image url" if image_file_url.present? && image_url.present? 
  end

  private
  def clear_image_file_if_image_url_given
    # if the image_url has been updated, but the image_file hasn't, assume the user wanted to clear the image_file
    if image_url_changed? && !image_file_changed?
      self.remove_image_file!
    end
  end
end


