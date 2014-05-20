class Cheerup < ActiveRecord::Base
  attr_accessible :user_id, :image_url, :message, :state

  belongs_to :user
  has_many :feedbacks

  validates :message, presence: true
  validates_length_of :message, maximum: 141 
  validates :user_id, presence: true
  validates :image_url, presence: true
  validates :state, :inclusion => {:in => ["flagged", "banned", "published"]}

  scope :bans, -> { where(state: "banned") }
  scope :flags, -> { where(state: "flagged") }
  scope :published, -> { where(state: "published") }
  
  #mount_uploader :image_url, CheerupImageUploader

  #mount_uploader :image_file, CheerupImageUploader

  after_initialize :defaults

  def likes_count
    self.feedbacks.where(kind: "like").count
  end

  def flags_count
    self.feedbacks.where(kind: "flag").count
  end

  def defaults
    self.image_url ||= 'none'
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

end


