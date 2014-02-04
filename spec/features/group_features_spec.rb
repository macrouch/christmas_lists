require 'spec_helper'

feature 'User creates a group' do
  background do
    sign_up_with 'testuser', 'test@example.com', 'password'
  end

  scenario "with valid attributes" do
    create_group_with('Test Group', 'What is 1+2?', '3')

    page.should have_content 'Group created'
    page.should have_content 'Test Group'
  end

  scenario "without valid attributes" do
    create_group_with('Test Group', '', '')

    page.should_not have_content 'Group created'
  end
end

feature 'User joins a group' do
  background do
    sign_up_with 'testuser', 'test@example.com', 'password'
    create_group_with('Test Group', 'What is 1+2?', '3')
    sign_out
    sign_up_with 'testuser2', 'test2@example.com', 'password'
  end

  scenario "with correct answer" do
    visit '/join_group/' + Group.first.id.to_s
    page.should have_content 'Joining Test Group'

    fill_in 'Answer', with: '3'
    click_button 'Join'

    page.should have_content 'Group joined'
  end

  scenario "with incorrect answer" do
    visit '/join_group/' + Group.first.id.to_s
    page.should have_content 'Joining Test Group'

    fill_in 'Answer', with: 'chicken'
    click_button 'Join'

    page.should have_content 'Joining Test Group'
    page.should have_content 'Incorrect answer, try again'
  end
end
