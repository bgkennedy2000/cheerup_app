class Cheerup < ActiveRecord::Base
  attr_accessible :user_id, :image_url, :message, :state, :image_file, :image_data

  belongs_to :user
  has_many :feedbacks

  validates_length_of :message, maximum: 141 
  validates :user_id, presence: true
  validate  :only_one_of_image_url_and_image_file_and_published
  validate :message_and_published
  validate :has_image
  validate :valid_url_for_draft
  validates :state, :inclusion => {:in => ["flagged", "banned", "published", "draft"]}

  scope :bans, -> { where(state: "banned") }
  scope :flags, -> { where(state: "flagged") }
  scope :published, -> { where(state: "published") }
  
  mount_uploader :image_file, CheerupImageUploader

  after_initialize :defaults
  before_validation :clear_image_file_if_image_url_given

  include FileUtils
  include Magick

  def update_cheerup_attributes(params)
    image_data = params.delete(:image_data)
    if update_attributes(params)
      relative_location = "/composite_image_file/#{self.id}/composite_image.png"
      path = "#{Rails.root}/public" + relative_location
      make_dir_if_none_exists(path)
      create_image_from_data(image_data, path)
      self.update_attribute(:image_url, relative_location)
    else
      false
    end
  end

  def make_cheerup
    if save
      process_image
      true
    else
      false
    end
  end

  def process_image
    #note: need to implement error handling for imageList
    if image_url && image_url != ""
      begin
        new_image = ImageList.new(image_url).resize_to_fit(510, 510)
        relative_location = "/captured_image_file/#{self.id}/image.#{new_image.format.downcase}"
        new_file_location = "#{Rails.root}/public" + relative_location
        make_dir_if_none_exists(new_file_location)
        new_image.write(new_file_location)
        self.image_url = relative_location        
      rescue
        errors.add :base, "unable to access image"

      end

    end
   end

  def make_dir_if_none_exists(file_path)
    dirname = File.dirname(file_path)
    unless File.directory?(dirname)
      FileUtils.mkdir_p(dirname)
    end
  end

  def create_image_from_data(data, path)
    # decode data and remove junk at bigging of base64 file
    image_data = Base64.decode64(data['data:image/png;base64,'.length .. -1])

    File.open(path, 'wb') do |f|
      f.write image_data
    end
  end

  def defaults
    self.state = "draft"
  end

  def likes_count
    self.feedbacks.where(kind: "like").count
  end

  def flags_count
    self.feedbacks.where(kind: "flag").count
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

  def calculated_image_url
    image_url.present? && URLImageValidator.valid?(image_url) ? image_url : image_file_url
  end

  private
  def message_and_published
    if self.state != 'draft'
      errors.add :base, "you must include a message to publish a cheerup" if message.nil? 
    end
  end


  def only_one_of_image_url_and_image_file_and_published
    if self.state != 'draft'
      errors.add :base, "you can only include an image or an image url" if image_file_url.present? && image_url.present? 
    end
  end

  def has_image
    errors.add :base, "please provide a valid image file" if image_url.blank? && image_file.blank? 
  end

  private
  def valid_url_for_draft
    if state == "draft" && image_url.present?
      errors.add :base, "url does not appear to be valid" unless URLImageValidator.valid?(image_url)
    end
  end

  private
  def clear_image_file_if_image_url_given
    # if the image_url has been updated, but the image_file hasn't, assume the user wanted to clear the image_file
    if image_url_changed? && !image_file_changed?
      self.remove_image_file!
    end
  end
end