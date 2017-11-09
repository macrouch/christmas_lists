require 'rails_helper'

describe SubGroup do
  it { should belong_to :group }
  it { should have_many :sub_group_members }
  it { should have_many(:members).through(:sub_group_members) }
end
