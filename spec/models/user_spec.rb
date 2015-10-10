require 'rails_helper'

describe User do
  it { should have_many :lists }
  it { should have_many :item_comments }
  it { should have_many :group_members }
  it { should have_many(:groups).through(:group_members) }
  it { should have_one :group }
  it { should validate_presence_of :name }
  it { should validate_presence_of :uid }
  it { should validate_presence_of :provider }
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of :email }
end
