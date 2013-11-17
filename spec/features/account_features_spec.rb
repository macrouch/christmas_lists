require 'spec_helper'

feature 'Visitor signs up' do
  scenario 'with valid email and password' do
    sign_up_with 'testuser', 'test@example.com', 'password'
    page.should have_content 'Logout testuser'
  end
  
  scenario 'with invalid email' do
    sign_up_with 'testuser', 'test', 'password'
    page.should have_content 'New Account'
  end
  
  scenario 'with blank password' do
    sign_up_with 'testuser', 'test@example.com', ''
    page.should have_content 'New Account'
  end
end

feature 'user signs in' do
  scenario 'with valid email and password' do
    sign_up_with 'testuser', 'test@example.com', 'password'  
    sign_out
    sign_in_with 'test@example.com', 'password'
    page.should have_content 'Logout testuser'
  end
  
  scenario 'with invalid password' do
    sign_up_with 'testuser', 'test@example.com', 'password'  
    sign_out
    sign_in_with 'test@example.com', 'passwrd'
    page.should have_content 'Create an account or login below.'    
  end
end
