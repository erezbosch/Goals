require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  it "has a new user page" do
    visit new_user_url
    expect(page).to have_content "Sign up"
  end

  feature "signing up a user" do

    it "shows username on the homepage after signup" do
      visit new_user_url
      fill_in 'username', with: "test"
      fill_in 'password', with: "password123"
      click_on "Create user"
      expect(page).to have_content "test"
    end
  end
end

feature "logging in" do

  it "shows username on the homepage after login" do
    visit new_session_url
    fill_in 'username', with: "test"
    fill_in 'password', with: "password123"
    click_on "Sign in"

    expect(page).to have_content "test"
  end
end

feature "logging out" do

  it "begins with logged out state" do
      visit root_url
      expect(page).to have_content "Sign in"
      end

  it "doesn't show username on the homepage after logout" do
    visit new_session_url
    fill_in 'username', with: "test"
    fill_in 'password', with: "password123"
    click_on "Sign in"
          
    click_on "Sign out"
    expect(page).to_not have_content "test"
  end

end
