class List < ActiveRecord::Base
  has_many :items
  belongs_to :user
  belongs_to :collection

  validates :name, presence: true
  validates :collection_id, presence: true

end
