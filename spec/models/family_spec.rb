require 'spec_helper'

describe Family do
  it { should belong_to :user }
  it { should have_many :collections }
  it { should have_many :family_members }
  it { should have_many(:members).through(:family_members) }
  it { should validate_presence_of :name }
  it { should validate_presence_of :question }
  it { should validate_presence_of :answer }
  it { should validate_presence_of :user_id }
end
