class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :profile_pic, :location, :username, :role, :tagline, :cover_image_url
  

  has_many :cheerups, :dependent => :destroy
  has_many :feedbacks, :dependent => :destroy

  validates :username, presence: true
  validates :role, :inclusion => {:in => ["admin", "user", "banned", "guest"]}

  after_initialize :defaults

  def likes
    self.feedbacks.where(kind: "like")
  end

  def flags
    self.feedbacks.where(kind: "flags")
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
end


def defaults
  self.location ||= 'none'
  self.profile_pic ||= 'none'
  self.tagline ||= 'none'
  self.cover_image_url ||= 'none'
  self.role ||= "guest"
end
