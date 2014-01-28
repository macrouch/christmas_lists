class FamilyMember < ActiveRecord::Base
  belongs_to :family
  belongs_to :user

  validates :family_id, presence: true
  validates :user_id, presence: true
end
