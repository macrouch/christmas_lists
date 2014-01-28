require 'spec_helper'

describe User do
  it { should have_many :lists }
  it { should have_many :item_comments }
  it { should have_many :family_members }
  it { should have_many(:families).through(:family_members) }
  it { should have_one :family }
  it { should validate_presence_of :name }
  it { should validate_presence_of :uid }
  it { should validate_presence_of :provider }
end
