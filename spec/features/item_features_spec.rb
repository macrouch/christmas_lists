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

  scenario 'without item being visible to owner' do
    create_list_with 'Second List', ''
    within("##{name_to_id('Second List')}") do
      click_link 'Add Item'
    end
    create_item_in_another_list_with 'Secret Item', 'item description', false, false
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

feature 'User marks item as purcased' do
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
    page.should have_css('i.icon-check')
  end

  scenario 'purchases secret item' do
    within("##{name_to_id('Second List')}") do
      click_link 'Add Item'
    end
    create_item_in_another_list_with 'Secret Item', 'item description', false, false
    click_link 'Secret Item'
    purchase_item
    page.should have_css('i.icon-exclamation-sign')
    page.should have_css('i.icon-check')
  end


end
