require 'rails_helper'

describe 'List sorting' do
  before do
    sign_up_with 'testuser', 'test@example.com', 'password'
    create_group_with 'Test Group', 'What is 1+2?', '3'
    user = User.first
    collection = user.groups.first.collections.first

    5.times do |i|
      collection.lists.create(name: "List #{i}")
    end

    collection.lists.create(name: 'Test User\'s List', user: user)

    visit collection_path(collection)
  end

  it 'displays the users list first' do
    within all('.list-header').first do
      expect(page).to have_content 'Test User\'s List'
    end
  end
end
