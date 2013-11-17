require 'spec_helper'

feature 'User creates list' do
  background do
    sign_up_with 'testuser', 'test@example.com', 'password'    
  end
  
  scenario 'with valid name and user' do
    create_list_with 'Test List', 'testuser'
    page.should have_content 'Test List'
    page.should have_content 'Owner: testuser'
  end

  scenario 'with valid name and no user' do
    create_list_with 'Test List', ''
    page.should have_content 'Test List'
    page.should_not have_content 'Owner: testuser'
  end

  scenario 'without name and user' do
    create_list_with '', ''
    page.should have_content "Name can't be blank"
  end
end

feature 'User edits list' do
  background do
    sign_up_with 'testuser', 'test@example.com', 'password'    
    create_list_with 'Test List', 'testuser'
    click_link 'Edit'
  end

  scenario 'with valid name and user' do
    edit_list_with 'test list', 'testuser'
    page.should have_content 'test list'
  end

  scenario 'without name and user' do
    edit_list_with '', ''
    page.should have_content "Name can't be blank"
  end

end
