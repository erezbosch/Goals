require 'rails_helper'

describe 'Cheers' do
  let!(:test) { create(:user) }
  let!(:test_two) { create(:user_two) }
  let!(:test_three) { create(:user) }
  let!(:goals) { create_list(:goal, 11,  user: test) }

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

  feature "Leaderboard" do
    it "accurately counts cheers" do
      sign_in(test_two)
      goals[0..1].each do |goal|
        visit goal_url(goal)
        click_on "Cheer"
      end
      click_on("Sign out")
      sign_in(test_three)
      visit goal_url(goals.first)
      click_on "Cheer"

      visit leaderboard_url
      expect(page).to have_content("2")
      expect(page).to have_content("1")
    end
  end
end
