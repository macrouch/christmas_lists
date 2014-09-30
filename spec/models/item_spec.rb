require 'spec_helper'

describe Item do
  it { should belong_to :list }
  it { should have_many :item_comments }
  it { should validate_presence_of :name }
  it { should validate_presence_of :list }
  it { should ensure_length_of(:description).is_at_most(256)}
  # it { should validate_presence_of :hidden_from_owner }

  it "shortens urls in descriptions" do
    VCR.use_cassette 'item' do
      item = Item.new({name: 'test', description: 'This is a cool link http://www.google.com', list: List.new()})
      item.shorten_urls
      item.should be_valid
    end
  end
end
