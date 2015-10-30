class SubGroup < ActiveRecord::Base
  belongs_to :group
  
  has_many :sub_group_members
  has_many :members, through: :sub_group_members, source: :user
end
