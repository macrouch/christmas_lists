require 'rails_helper'

feature 'User creates a group' do
  background do
    sign_up_with 'testuser', 'test@example.com', 'password'
  end

  scenario "with valid attributes" do
    create_group_with 'Test Group', 'What is 1+2?', '3'

    page.should have_content 'Group created'
    page.should have_content 'Test Group'
  end

  scenario "without valid attributes" do
    create_group_with 'Test Group', '', ''

    page.should_not have_content 'Group created'
  end
end

feature 'User joins a group' do
  background do
    sign_up_with 'testuser', 'test@example.com', 'password'
    create_group_with 'Test Group', 'What is 1+2?', '3'
    sign_out
    sign_up_with 'testuser2', 'test2@example.com', 'password'
  end

  scenario "with correct answer" do
    visit '/join_group/' + Group.first.to_param.to_s
    page.should have_content 'Joining Test Group'

    fill_in 'Answer', with: '3'
    click_button 'Join'

    page.should have_content 'Group joined'
  end

  scenario "with incorrect answer" do
    visit '/join_group/' + Group.first.to_param.to_s
    page.should have_content 'Joining Test Group'

    fill_in 'Answer', with: 'chicken'
    click_button 'Join'

    page.should have_content 'Joining Test Group'
    page.should have_content 'Incorrect answer, try again'
  end

  scenario "cant join a group you are already a member of" do
    visit '/join_group/' + Group.first.to_param.to_s
    page.should have_content 'Joining Test Group'

    fill_in 'Answer', with: '3'
    click_button 'Join'

    visit '/join_group/' + Group.first.to_param.to_s
    page.should have_content 'You are already a member of Test Group'
  end
end

feature 'User leaves a group' do
  background do
    sign_up_with 'testuser', 'test@example.com', 'password'
    create_group_with 'Test Group', 'What is 1+2?', '3'
  end

  scenario 'leaves group successfully' do
    sign_out
    sign_up_with 'testuser2', 'test2@example.com', 'password'
    visit '/join_group/' + Group.first.to_param.to_s
    page.should have_content 'Joining Test Group'
    fill_in 'Answer', with: '3'
    click_button 'Join'

    visit groups_path
    click_link 'Options'
    click_link 'Leave Group'

    page.should have_content "Left group successfully"
  end

  scenario 'cant leave group user created' do
    visit groups_path
    click_link 'Options'

    page.should_not have_content 'Leave Group'
  end
end

feature "User removes a group member" do
  background do
    sign_up_with 'testuser', 'test@example.com', 'password'
    create_group_with 'Test Group', 'What is 1+2?', '3'
  end

  scenario "cannot remove self from group" do
    visit groups_path
    click_link 'Members'

    page.should_not have_content 'Remove'
  end

  scenario "cannot remove members from group I didn't start" do
    sign_out
    sign_up_with 'testuser2', 'test2@example.com', 'password'
    visit '/join_group/' + Group.first.to_param.to_s
    page.should have_content 'Joining Test Group'
    fill_in 'Answer', with: '3'
    click_button 'Join'
    visit groups_path

    click_link 'Members'

    page.should_not have_content 'Remove'
  end

  scenario "successfully removes group member" do
    sign_out
    sign_up_with 'testuser2', 'test2@example.com', 'password'
    visit '/join_group/' + Group.first.to_param.to_s
    page.should have_content 'Joining Test Group'
    fill_in 'Answer', with: '3'
    click_button 'Join'
    sign_out

    sign_in_with 'test@example.com', 'password'
    visit groups_path
    click_link 'Members'
    click_link 'Remove'

    page.should have_content 'testuser2 successfully removed from Test Group'
  end

end

feature "User cant view collections for groups without membership" do
  background do
    sign_up_with 'testuser', 'test@example.com', 'password'
    create_group_with 'Test Group', 'What is 1+2?', '3'
    create_list_with 'Test List', 'testuser'
    sign_out
    sign_up_with 'testuser2', 'test2@example.com', 'password'
  end

  scenario "cant view collection without group membership" do
    visit collection_path(Collection.first)

    page.should have_content "You are not a member of that group"
  end

  scenario "cant add list without group membership" do
    visit new_collection_list_path(Collection.first)

    page.should have_content "You are not a member of that group"
  end

  scenario "cant add an item without group membership" do
    visit new_collection_list_item_path(Collection.first, List.first)

    page.should have_content "You are not a member of that group"
  end
end
