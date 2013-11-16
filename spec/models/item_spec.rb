require 'spec_helper'

describe Item do
  it { should have_many :list_items }
  it { should validate_presence_of :name }
end
