require 'spec_helper'

describe Identity do
  it { should validate_presence_of :name }
  # it { should validate_uniqueness_of :email }
  it { should allow_value("test@test.com").for(:email)}
  it { should_not allow_value('test').for(:email) }
end
