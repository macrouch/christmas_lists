require 'spec_helper'

feature 'User creates a family' do
  background do
    sign_up_with 'testuser', 'test@example.com', 'password'    
  end

  scenario "with valid attributes" do
    create_family_with('Test Family', 'What is 1+2?', '3')

    page.should have_content 'Family created'
    page.should have_content 'Test Family'
  end

  scenario "without valid attributes" do
    create_family_with('Test Family', '', '')

    page.should_not have_content 'Family created'
  end
end

feature 'User joins a family'
