class Collection < ActiveRecord::Base
  belongs_to :family
  has_many :lists

  validates :family_id, presence: true
  validates :name, presence: true
end
