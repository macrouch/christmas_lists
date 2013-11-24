module Features
  module Helpers
    ### Identity Helpers
    def sign_up_with(name, email, password)
      visit new_identity_path
      fill_in 'Name', with: name
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      fill_in 'Password confirmation', with: password
      click_button 'Register'
    end

    def sign_in_with (email, password)
      visit root_url
      fill_in "Email", :with => email
      fill_in "Password", :with => password
      click_button "Login"
    end

    def update_password(password, confirmation)
      visit root_url
      click_link 'Change Password'
      fill_in 'Password', with: password
      fill_in 'Password confirmation', with: confirmation
      click_button 'Update Password'
    end

    def sign_out
      visit root_url
      click_link "Logout"
    end

    ### List Helpers
    def create_list_with(name, user)
      visit new_list_path
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
    def create_item_with(name, description)
      fill_in 'Name', with: name
      fill_in 'Description', with: description
      click_button 'Create Item'
    end

    def create_item_in_another_list_with(name, description, hidden_from_owner=true, purchased=false, purchased_by=nil)
      fill_in 'Name', with: name
      fill_in 'Description', with: description
      hidden_from_owner ? check('Hide item from list owner') : uncheck('Hide item from list owner')
      purchased ? check('Is the item purchased') : uncheck('Is the item purchased')
      fill_in 'Who purchased the item', with: purchased_by
      click_button 'Create Item'
    end

    def edit_item_with(name, description)
      fill_in 'Name', with: name
      fill_in 'Description', with: description
      click_button 'Update Item'
    end

    def purchase_item
      check('Is the item purchased')
      fill_in 'Who purchased the item', with: 'testuser'
      click_button 'Update Item'
    end
  end
end
