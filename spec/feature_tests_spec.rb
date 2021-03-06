require 'spec_helper'
require 'test_helpers'

feature 'Viewing the homepage' do
  scenario "allows user to visit homepage" do
    visit('/')
    expect(page).to have_content "welcome to makersbnb"
  end
end

feature 'User can sign up' do
  scenario "allows user to sign up" do
    visit('/')
    within('#signup-form') do
      fill_in :email, with: 'rspec@test.com'
      fill_in :password, with: '1234'
      click_button("submit")
    end

    expect(page).to have_content 'welcome rspec@test.com!'
  end
end

feature 'Authentication' do
  scenario "user can log in" do
    signup_and_login
    expect(page).to have_content("welcome test@example.com")
  end

  scenario "a user sees an error message if email is wrong" do
    signup
    fill_in(:email, with: 'wrong@wrong.wrong')
    fill_in(:password, with: 'password123')
    click_button('log in')
    expect(page).not_to have_content 'Welcome, test@example.com'
    expect(page).to have_content 'wrong email or password'
 end

 scenario "a user sees an error message if password is wrong" do
    signup
    fill_in(:email, with: 'test@example.com')
    fill_in(:password, with: 'wrongpassword')
    click_button('log in')
    expect(page).not_to have_content 'Welcome, test@example.com'
    expect(page).to have_content 'wrong email or password'
 end
end

feature 'Signing out' do
  scenario 'a user can sign out' do
    signup_and_login
    click_button('log out')
    expect(page).not_to have_content 'Welcome, test@example.com'
    expect(page).to have_content 'you have signed out'
  end
end

feature 'Viewing listings' do
  scenario 'a user can see a list of spaces after logging in' do
    populate_listings
    signup_and_login
    expect(page).to have_content 'test_5'
    expect(page).to have_content '2_description'
    expect(page).to have_content '$30.00'
  end
end

feature 'Creating a listing' do
  scenario 'a user can create a listing' do
    signup_and_login
    click_button('create listing')
    fill_in(:name, with: 'test_name')
    fill_in(:description, with: 'test_description')
    fill_in(:price, with: 12.00)
    click_button('create listing')
    expect(page).to have_content 'test_name'
    expect(page).to have_content 'test_description'
    expect(page).to have_content '$12.00'
  end
end

 # scenario 'a user cant sign up with empty details' do
 #   visit '/'
 #   click_button('sign up')
 #   click_button('log in')
 #   click_button('log in')
 #   expect()
