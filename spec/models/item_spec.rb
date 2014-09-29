require 'spec_helper'

describe Item do
  it { should belong_to :list }
  it { should have_many :item_comments }
  it { should validate_presence_of :name }
  it { should validate_presence_of :list }
  it { should ensure_length_of(:description).is_at_most(256)}
  # it { should validate_presence_of :hidden_from_owner }
end
