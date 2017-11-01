require 'rails_helper'

feature 'Drawing names in a group', js: true do
  background do
    sign_up_with 'testuser', 'test@example.com', 'password'
    create_group_with 'Test Group', 'What is 1+2?', '3'

    # create a lot of users and add to the group
    10.times do |i|
      member = User.create(
        name: "User #{i + 2}",
        uid: "user_#{i + 2}",
        provider: 'identity',
        email: "user_#{i + 2}@example.com"
      )

      group = Group.first
      group.members << member
      group.save
    end
  end

  scenario 'group should have 11 members' do
    Group.first.members.size.should eq(11)
  end

  context 'when dividing the group into sub groups' do
    background do
      visit draw_names_path(Group.first)
      page.driver.resize 1920, 1080

      # Drag two users to each group, resulting in 5 subgroups
      id = 1
      10.times do |i|
        source = page.find("li[data-member-id='#{i + 2}']")
        target = page.find("#sortable-#{id}")
        source.drag_to(target)
        id += 1 if i.odd?
      end

      click_on 'Save Sub-Groups'
    end

    scenario 'saves the members into sub groups' do
      Group.first.sub_groups.size.should eq(5)
    end
  end
end
