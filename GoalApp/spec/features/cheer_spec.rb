require 'rails_helper'

describe 'Cheers' do
  let(:test) { create(:user) }
  let(:test_two) { create(:user_two) }
  let(:goals) { create_list(:goal, 11,  user: test) }

  feature "Create" do
    it "can create a cheer for another user's goal" do
      sign_in(test_two)
      visit goal_url(goals.first)
      click_on "Cheer"

      expect(page).to have_content("#{test_two.username} cheered this goal")
    end

    it "can't cheer your own goal" do
      sign_in(test)
      visit goal_url(goals.first)
      click_on "Cheer"

      expect(page).to have_content("Can't cheer your own goal")
    end

    it "can't cheer the same goal twice" do
      sign_in(test_two)
      visit goal_url(goals.first)
      click_on "Cheer"
      click_on "Cheer"

      expect(page).to have_content("Can't cheer goal more than once")
    end

    it "allows 10 cheers max per user" do
      sign_in(test_two)
      goals.each do |goal|
        visit goal_url(goal)
        click_on "Cheer"
      end

      expect(page).to have_content("You are out of cheers")
    end
  end
end
