class Collection < ActiveRecord::Base
  belongs_to :group
  has_many :lists
  has_many :name_drawings

  validates :group_id, presence: true
  validates :name, presence: true

  default_scope { order(name: :desc) }

  obfuscate_id spin: 658165144
end
