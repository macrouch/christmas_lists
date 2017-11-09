require 'rails_helper'

describe Notification do
  it { should have_many :user_notifications }
  it { should validate_presence_of :title }
  it { should validate_presence_of :message }
end
