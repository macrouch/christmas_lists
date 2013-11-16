require 'spec_helper'

describe User do
  it { should have_many :lists }
  it { should validate_presence_of :name }
  it { should validate_presence_of :uid }
  it { should validate_presence_of :provider }
end
