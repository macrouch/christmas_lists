require 'rails_helper'

describe Collection do
  it { should belong_to :group }
  it { should have_many :lists }
  it { should validate_presence_of :group_id }
  it { should validate_presence_of :name }
end
