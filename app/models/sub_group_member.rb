class SubGroupMember < ActiveRecord::Base
  belongs_to :sub_group
  belongs_to :user
  
  validates :sub_group_id, presence: true
  validates :user_id, presence: true
end
