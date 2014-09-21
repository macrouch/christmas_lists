class Group < ActiveRecord::Base
  belongs_to :user
  has_many :collections
  has_many :group_members
  has_many :members, through: :group_members, source: :user

  validates :name, presence: true
  validates :question, presence: true
  validates :answer, presence: true
  validates :user_id, presence: true

  obfuscate_id spin: 48151248
end
