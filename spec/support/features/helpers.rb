module Features
  module Helpers
    ### Identity Helpers
    def sign_up_with(name, email, password)
      visit new_identity_path
      fill_in 'Name', with: name
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      fill_in 'Confirm Password', with: password
      click_button 'Register'
      visit user_activation_path(User.last.email_token) if User.last
    end

    def sign_in_with (email, password)
      visit root_path
      fill_in "Email", :with => email
      fill_in "Password", :with => password
      click_button "Login"
    end

    def update_password(password, confirmation)
      visit root_path
      click_link 'Change Password'
      fill_in 'Password', with: password
      fill_in 'Confirm Password', with: confirmation
      click_button 'Update Password'
    end

    def sign_out
      visit root_path
      click_link "Logout"
    end

    ### List Helpers
    def create_list_with(name, user)
      visit new_collection_list_path(Collection.first)
      fill_in 'Name', with: name
      if user == ''
        select 'Select Owner/Not Listed', from: 'Owner'
      else
        select user, from: 'Owner'
      end
      click_button 'Create List'
    end

    def edit_list_with(name, user)
      fill_in 'Name', with: name
      if user == ''
        select 'Select Owner/Not Listed', from: 'Owner'
      else
        select user, from: 'Owner'
      end
      click_button 'Update List'
    end

    ### Item Helpers
    def create_item_with(name, description, image_url=nil)
      fill_in 'Name', with: name
      fill_in 'Description', with: description
      change_to_image_url
      fill_in 'New Image Url', with: image_url if image_url
      click_button 'Create Item'
    end

    def create_item_in_another_list_with(name, description, hidden_from_owner=true, purchased=false, purchased_by=nil)
      fill_in 'Name', with: name
      fill_in 'Description', with: description
      check_hide_item(hidden_from_owner)
      check_purchased(purchased)
      fill_in 'Purchased by', with: purchased_by
      click_button 'Create Item'
    end

    def edit_item_with(name, description, image_url=nil)
      fill_in 'Name', with: name
      fill_in 'Description', with: description
      change_to_image_url
      fill_in 'New Image Url', with: image_url if image_url
      click_button 'Update Item'
    end

    def purchase_item
      check_purchased(true)
      fill_in 'Purchased by', with: 'testuser'
      click_button 'Update Item'
    end

    def create_item_comment(comment, hidden)
      click_link 'Add New Comment'
      fill_in 'Comment', with: comment
      check_private_comment(hidden)
      click_button 'Add Comment'
    end

    def change_to_image_url
      page.execute_script "$('span.toggle-image').click()"
    end

    def check_hide_item(value)
      script = "$('.hide-item-checkbox').prop('checked', #{value});"
      page.execute_script script
    end

    def check_purchased(value)
      script = "$('.purchased-checkbox').prop('checked', #{value});"
      page.execute_script script
    end

    def check_private_comment(value)
      script = "$('.private-comment-checkbox').prop('checked', #{value});"
      page.execute_script script
    end

    ### Group Helpers
    def create_group_with(name, question, answer)
      visit new_group_path
      fill_in 'Name', with: name
      fill_in 'Question', with: question
      fill_in 'Answer', with: answer
      click_button 'Create Group'
    end

  end
end
