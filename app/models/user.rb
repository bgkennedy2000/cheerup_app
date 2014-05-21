class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:twitter]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :profile_pic, :location, :username, :tagline, :cover_image_url, :provider, :uid, :oauth_token, :oauth_secret

  has_many :cheerups, :dependent => :destroy
  has_many :feedbacks, :dependent => :destroy

  validates :username, presence: true
  validates :role, :inclusion => {:in => ["admin", "user", "banned", "guest"]}

  mount_uploader :profile_pic, ProfileImageUploader

  after_initialize :defaults

  before_save :update_user_role

  def likes
    self.feedbacks.where(kind: "like")
  end

  def flags
    self.feedbacks.where(kind: "flag")
  end

  def valid_cheerups
    self.cheerups.where(state: "published")
  end

  def flagged_cheerups
    self.cheerups.where(state: "flagged")
  end

  def banned_cheerups
    self.cheerups.where(state: "banned")
  end

  def defaults
    self.location ||= 'none'
    self.profile_pic ||= 'none'
    self.tagline ||= 'none'
    self.cover_image_url ||= 'none'
    self.role ||= "guest"
  end

  def self.from_omniauth(auth)
    if user = User.find_by_email(auth.info.nickname+"@twitter.com")
      user.provider = auth.provider
      user.uid = auth.uid
      user.oauth_token = auth.credentials.token
      user.oauth_secret = auth.credentials.secret
      user

    else
      where(auth.slice(:provider, :uid)).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.username = auth.info.nickname
        user.email = auth.info.nickname+"@twitter.com"
        user.password = Devise.friendly_token[0,20]
        user.oauth_token = auth.credentials.token
        user.oauth_secret = auth.credentials.secret
      end
    end
  end


  def role?(role)
    self.role.to_s == role.to_s
  end

  def update_user_role
    if self.role == "guest"
      self.role = "user"
    end
  end

  def rating
    rating = 0

    cheerups.each do |cheerup|
      rating += cheerup.rating
    end
    return rating
  end

  def tweet(cheerup)

    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['CHEERUP_APP_TWITTER_API_KEY']
      config.consumer_secret     = ENV['CHEERUP_APP_TWITTER_API_SECRET']
      config.access_token        = oauth_token
      config.access_token_secret = oauth_secret
    end
    client.update_with_media(cheerup.message, File.new("./public"+cheerup.calculated_image_url)) 
  end

end



