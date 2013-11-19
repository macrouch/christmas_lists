class Item < ActiveRecord::Base
  belongs_to :list

  validates :name, presence: true
  validates :list, presence: true
  # validates :visible_to_owner, presence: true

end
