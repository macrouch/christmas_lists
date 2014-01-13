class ItemComment < ActiveRecord::Base
  belongs_to :item
  belongs_to :user

  validates :comment, presence: true
  validates :user_id, presence: true
  validates :item_id, presence: true
end
