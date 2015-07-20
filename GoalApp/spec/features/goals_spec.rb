require 'rails_helper'

describe "Goals" do
  let(:test) { create(:user) }
  let(:test2) { create(:user_two) }

  feature "Create" do
    before(:each) { sign_in(test) }
    before(:each) { visit new_goal_url }

    it "Has a create goal page" do
      expect(page).to have_content("Make a new goal")
    end

    it "Displays errors after a failed goal creation" do
      fill_in "Body", with: "Run a marathon"
      click_on "Create goal"
      expect(page).to have_content("can't be blank")
    end

    it "Redirects to goal's show page" do
      fill_in "Body", with: "Run a marathon"
      choose "Public"
      click_on "Create goal"
      expect(page).to have_content("Run a marathon")
    end
  end

  feature "Read" do
    let(:goal_one) { create(:goal, user: test) }
    let(:goal_two) { create(:private_goal, user: test) }

    it "Allows user to see their own private goals" do
      sign_in(test)
      visit goal_url(goal_two)
      expect(page).to have_content(goal_two.body)
    end

    it "Doesn't allow other users to see private goals" do
      sign_in(test2)
      visit goal_url(goal_two)
      expect(page).not_to have_content(goal_two.body)
    end

    it "Allows other users to see public goals" do
      sign_in(test2)
      visit goal_url(goal_one)
      expect(page).to have_content(goal_one.body)
    end
  end

  feature "Update" do
    let(:goal) { create(:goal, user: test) }
    before(:each) { sign_in(test) }

    it "Has a link to update on goal show page" do
      visit goal_url(goal)
      expect(page).to have_content("Update goal")
    end

    it "Pre-fills values on update page" do
      visit goal_url(goal)
      click_on "Update goal"
      expect(find_field("Body").value).to eq(goal.body)
    end

    it "Allows user to update own goals" do
      visit goal_url(goal)
      click_on "Update goal"
      fill_in "Body", with: "Run a half-marathon"
      click_on "Update"
      expect(page).to have_content("Run a half-marathon")
    end

    it "Doesn't allow other users to update a user's goals" do
      click_on("Sign out")
      sign_in(test2)
      visit goal_url(goal)
      expect(page).to_not have_content("Update goal")
    end
  end

  feature "Destroy" do
    let(:goal) { create :goal, user: test }

    it "User who created goal has a link to destroy it" do
      sign_in(test)
      visit goal_url(goal)
      expect(page).to have_content("Delete goal")
    end

    it "Allows user to destroy own goal" do
      sign_in(test)
      visit goal_url(goal)
      click_on "Delete goal"
      expect(page).to_not have_content("Run a marathon")
    end

    it "Doesn't allow other users to delete a user's goals" do
      sign_in(test2)
      visit goal_url(goal)
      expect(page).to_not have_content("Delete goal")
    end
  end

end
