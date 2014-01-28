require 'spec_helper'

describe FamilyMember do
  it { should belong_to :family }
  it { should belong_to :user }
  it { should validate_presence_of :family_id }
  it { should validate_presence_of :user_id }
end
