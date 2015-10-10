require 'rails_helper'

describe List do
  it { should have_many :items }
  it { should belong_to :user }
  it { should belong_to :collection }
  it { should validate_presence_of :name }
  it { should validate_presence_of :collection_id }
end
