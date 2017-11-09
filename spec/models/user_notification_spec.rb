require 'rails_helper'

describe UserNotification do
  it { should belong_to :user }
  it { should belong_to :notification }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :notification_id }
end
