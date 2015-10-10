require 'rails_helper'

describe Group do
  it { should belong_to :user }
  it { should have_many :collections }
  it { should have_many :group_members }
  it { should have_many(:members).through(:group_members) }
  it { should validate_presence_of :name }
  it { should validate_presence_of :question }
  it { should validate_presence_of :answer }
  it { should validate_presence_of :user_id }
end
