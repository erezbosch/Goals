require 'spec_helper'
require 'rails_helper'
describe 'auth' do
  let(:test) { create :user }
  
  feature "the signup process" do


    it "has a new user page" do
      visit new_user_url
      expect(page).to have_content "Sign up"
    end

    feature "signing up a user" do

      it "shows username on the homepage after signup" do
        sign_up(test)

        expect(page).to have_content test.username
      end
    end
  end

  feature "logging in" do

    it "shows username on the homepage after login" do
      sign_up(test)

      click_on "Sign out"

      visit new_session_url
      sign_in(test)

      expect(page).to have_content test.username
    end
  end

  feature "logging out" do

    it "begins with logged out state" do
        visit root_url
        expect(page).to have_content "Sign in"
        end

    it "doesn't show username on the homepage after logout" do
      sign_up(test)

      click_on "Sign out"
      expect(page).to_not have_content test.username
    end

  end

end
