require 'spec_helper'

feature 'Visitor signs up' do
  scenario 'with valid email and password' do
    sign_up_with 'testuser', 'test@example.com', 'password'
    page.should have_content 'Signed in'
    page.should have_content 'Logout testuser'
  end
  
  scenario 'with invalid email' do
    sign_up_with 'testuser', 'test', 'password'
    page.should have_content 'Email is invalid'
    page.should have_content 'New Account'
  end
  
  scenario 'with blank password' do
    sign_up_with 'testuser', 'test@example.com', ''
    page.should have_content "Password can't be blank"
    page.should have_content 'New Account'
  end
end

feature 'User signs in' do
  background do
    sign_up_with 'testuser', 'test@example.com', 'password'  
    sign_out    
  end

  scenario 'with valid email and password' do
    sign_in_with 'test@example.com', 'password'
    page.should have_content 'Signed in'
    page.should have_content 'Logout testuser'
  end
  
  scenario 'with invalid password' do
    sign_in_with 'test@example.com', 'passwrd'
    page.should have_content 'Authentication failed, please try again'
    page.should have_content 'Create an account or login below.'    
  end
end

feature 'User changes password' do
  background do
    sign_up_with 'testuser', 'test@example.com', 'password'
  end

  scenario 'successfully changes password' do
    update_password 'newPassword', 'newPassword'
    page.should have_content 'Password successfully changed'
    sign_out
    sign_in_with 'test@example.com', 'newPassword'
    page.should have_content 'Signed in'
  end

  scenario 'passwords dont match' do
    update_password 'newPassword', 'password'
    page.should have_content "Password confirmation doesn't match Password"
  end
end
