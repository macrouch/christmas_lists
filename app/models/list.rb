class List < ActiveRecord::Base
  has_many :items
  belongs_to :user
  belongs_to :collection

  validates :name, presence: true
  validates :collection_id, presence: true

  obfuscate_id spin: 65135134

  def username
    if self.user
      self.user.name
    else
      nil
    end
  end
end
