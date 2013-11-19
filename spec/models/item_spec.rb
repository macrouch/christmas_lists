require 'spec_helper'

describe Item do
  it { should belong_to :list }
  it { should validate_presence_of :name }
  it { should validate_presence_of :list }
  # it { should validate_presence_of :visible_to_owner }
end
