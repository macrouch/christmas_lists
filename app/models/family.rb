class Family < ActiveRecord::Base
  belongs_to :user
  has_many :collections
  has_many :family_members
  has_many :members, through: :family_members, source: :user

  validates :name, presence: true
  validates :question, presence: true
  validates :answer, presence: true
  validates :user_id, presence: true
end
