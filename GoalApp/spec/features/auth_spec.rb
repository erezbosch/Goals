require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  it "has a new user page" do
    visit new_user_url
    expect(page).to have_content "Sign up"
  end

  feature "signing up a user" do

    it "shows username on the homepage after signup" do
      sign_up_as_test

      expect(page).to have_content "test"
    end
  end
end

feature "logging in" do

  it "shows username on the homepage after login" do
    sign_up_as_test

    click_on "Sign out"

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
    sign_up_as_test

    click_on "Sign out"
    expect(page).to_not have_content "test"
  end

end
