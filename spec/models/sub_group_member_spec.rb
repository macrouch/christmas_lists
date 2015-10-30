require 'rails_helper'

describe SubGroupMember do
  it { should belong_to :sub_group }
  it { should belong_to :user }
  it { should validate_presence_of :sub_group_id }
  it { should validate_presence_of :user_id }
end
