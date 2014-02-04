class Collection < ActiveRecord::Base
  belongs_to :group
  has_many :lists

  validates :group_id, presence: true
  validates :name, presence: true

  default_scope { order(:name) }
end
