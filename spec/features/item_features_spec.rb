require 'spec_helper'

feature 'User creates item' do
  background do
    sign_up_with 'testuser', 'test@example.com', 'password'
    create_list_with 'Test List', 'testuser'
  end

  scenario 'with valid name and description' do
    click_link 'Add Item'
    create_item_with 'Item 1', 'Test item for my list'
    page.should have_content 'Item 1'
    page.should have_content 'Test item for my list'
  end

  scenario 'with valid name and no description' do
    click_link 'Add Item'
    create_item_with 'Item 1', ''
    page.should have_content 'Item 1'
  end

  scenario 'without name' do
    click_link 'Add Item'
    create_item_with '', ''
    page.should have_content "Name can't be blank"
  end
end

feature 'User edits an item' do
  background do
    sign_up_with 'testuser', 'test@example.com', 'password'
    create_list_with 'Test List', 'testuser'
    click_link 'Add Item'
    create_item_with 'Item 1', 'Test item for my list'
    click_link 'Item 1'
  end

  scenario 'with valid name and description' do
    edit_item_with 'Item 1 edit', 'Test item for my list edit'
    page.should have_content 'Item 1 edit'
    page.should have_content 'Test item for my list edit'
  end

  scenario 'without name' do
    edit_item_with '', ''
    page.should have_content "Name can't be blank"
  end
end
