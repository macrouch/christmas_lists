class UserNotification < ActiveRecord::Base
  belongs_to :user
  belongs_to :notification

  validates :user_id, presence: true
  validates :notification_id, presence: true

  delegate :title, to: :notification
  delegate :message, to: :notification
end
