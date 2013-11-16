class Item < ActiveRecord::Base
  has_many :list_items

  validates :name, presence: true

end
