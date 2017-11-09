class Notification < ActiveRecord::Base
  has_many :user_notifications

  validates :title, presence: true
  validates :message, presence: true
end
