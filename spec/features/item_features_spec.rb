require 'spec_helper'

include ListsHelper

feature 'User creates item' do
  background do
    sign_up_with 'testuser', 'test@example.com', 'password'
    create_list_with 'Test List', 'testuser'
  end

  scenario 'with valid name and description' do
    click_link 'Add Item'
    create_item_with 'Item 1', 'Test item for my list'
    page.should have_content 'Item created'
    page.should have_content 'Item 1'
    page.should have_content 'Test item for my list'
  end

  scenario 'with valid name and no description' do
    click_link 'Add Item'
    create_item_with 'Item 1', ''
    page.should have_content 'Item created'
    page.should have_content 'Item 1'
  end

  scenario 'without name' do
    click_link 'Add Item'
    create_item_with '', ''
    page.should have_content "Name can't be blank"
  end

  scenario 'without item being visible to owner' do
    create_list_with 'Second List', ''
    within("##{name_to_id('Second List')}") do
      click_link 'Add Item'
    end
    create_item_in_another_list_with 'Secret Item', 'item description', false, false
    page.should have_css('i.icon-exclamation-sign')
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
    page.should have_content 'Item updated'
    page.should have_content 'Item 1 edit'
    page.should have_content 'Test item for my list edit'
  end

  scenario 'without name' do
    edit_item_with '', ''
    page.should have_content "Name can't be blank"
  end
end

feature 'User marks item as purchased' do
  background do
    sign_up_with 'testuser', 'test@example.com', 'password'
    create_list_with 'Test List', 'testuser'
    create_list_with 'Second List', ''
    within("##{name_to_id('Second List')}") do
      click_link 'Add Item'
    end
    create_item_in_another_list_with 'Item 1', 'item description', true, false
  end

  scenario 'purchases normal item' do
    click_link 'Item 1'
    purchase_item
    page.should have_content 'Item updated'
    page.should have_css('i.icon-check')
  end

  scenario 'purchases secret item' do
    within("##{name_to_id('Second List')}") do
      click_link 'Add Item'
    end
    create_item_in_another_list_with 'Secret Item', 'item description', false, false
    click_link 'Secret Item'
    purchase_item
    page.should have_content 'Item updated'
    page.should have_css('i.icon-exclamation-sign')
    page.should have_css('i.icon-check')
  end
end

feature 'User deletes an item' do
  background do
    sign_up_with 'testuser', 'test@example.com', 'password'
    create_list_with 'Test List', 'testuser'
    click_link 'Add Item'
    create_item_with 'Item 1', 'Test item for my list'
    click_link 'Item 1'
  end

  scenario 'deletes an item' do
    click_link 'Delete Item'
    page.should have_content 'Item deleted'
  end
end

feature 'User adds comment to an item' do
  background do
    sign_up_with 'testuser', 'test@example.com', 'password'
    create_list_with 'Test List', ''
    within("##{name_to_id('Test List')}") do
      click_link 'Add Item'
    end
    create_item_in_another_list_with 'Item 1', 'item description', true, false
  end

  scenario 'adds a public comment' do
    create_item_comment 'Everyone can see this comment!', false
    page.should have_content 'Item Updated'

    click_link 'Item 1'
    page.should have_content 'Everyone can see this comment!'
  end

  scenario 'adds a private comment' do
    create_item_comment 'Only I can see this comment!', true
    page.should have_content 'Item Updated'

    click_link 'Item 1'
    page.should have_content 'Only I can see this comment!'    
  end
  
end
