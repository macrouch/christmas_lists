require 'spec_helper'

describe Collection do
  it { should belong_to :family }
  it { should have_many :lists }
  it { should validate_presence_of :family_id }
  it { should validate_presence_of :name }
end
