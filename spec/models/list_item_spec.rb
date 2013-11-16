require 'spec_helper'

describe ListItem do
  it { should belong_to :item }
  it { should belong_to :list }
  it { should validate_presence_of :list }
  it { should validate_presence_of :item }
  it { should validate_presence_of :visible_to_owner }
end
