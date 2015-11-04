class NameDrawing < ActiveRecord::Base
  belongs_to :collection
  belongs_to :picker, class_name: 'User', foreign_key: 'picker_id'
  belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'

  validates :collection, presence: true
  validates :picker_id, presence: true
  validates :receiver_id, presence: true
end
