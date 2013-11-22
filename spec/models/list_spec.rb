require 'spec_helper'

describe List do
  it { should have_many :items }
  it { should belong_to :user }
  it { should validate_presence_of :name }
end