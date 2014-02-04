require 'spec_helper'

describe GroupMember do
  it { should belong_to :group }
  it { should belong_to :user }
  it { should validate_presence_of :group_id }
  it { should validate_presence_of :user_id }
end
