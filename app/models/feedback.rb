class Feedback < ActiveRecord::Base
  attr_accessible :cheerup_id, :kind, :user_id

  belongs_to :user
  belongs_to :cheerup

  validates :cheerup_id, presence: true
  validates :user_id, presence: true
  validates :kind, :inclusion => {:in => ["like", "flag"]}
end
