class List < ActiveRecord::Base
  has_many :list_items
  belongs_to :user, foreign_key: :owner

  validates :name, presence: true

end
