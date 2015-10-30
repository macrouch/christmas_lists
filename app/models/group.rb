class Group < ActiveRecord::Base
  belongs_to :user
  has_many :collections
  has_many :group_members
  has_many :members, through: :group_members, source: :user
  has_many :sub_groups
  has_many :sub_group_members, through: :sub_groups, source: :members

  validates :name, presence: true
  validates :question, presence: true
  validates :answer, presence: true
  validates :user_id, presence: true

  obfuscate_id spin: 48151248

  def members_not_in_sub_group
    members.select { |member| !sub_group_members.include? member }
  end
end
