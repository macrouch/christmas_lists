class ListItem < ActiveRecord::Base
  belongs_to :list
  belongs_to :item

  validates :list, presence: true
  validates :item, presence: true
  validates :visible_to_owner, presence: true
end
