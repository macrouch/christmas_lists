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
  end
end
