require 'rails_helper'

describe "Comments" do
  feature "On Goals" do
    let(:test) { create(:user) }
    let(:goal) { create(:goal, user: test) }
      before :each do
        sign_in(test)
        visit goal_url(goal)
      end

    it "has a create comment form" do
      expect(page).to have_content("Add comment")
    end

    it "displays error if comment field is blank" do
      click_on "Add comment"
      expect(page).to have_content("can't be blank")
    end

    it "creates comments and redirects to goal show page" do
      fill_in "comment_body", with: "good luck"
      click_on "Add comment"
      expect(page).to have_content("good luck")
    end
  end

  feature "On Users" do
    let(:test) { create(:user) }
    before :each do
      sign_in(test)
      visit user_url(test)
    end

    it "has a create comment form" do
      expect(page).to have_content("Add comment")
    end

    it "displays error if comment field is blank" do
      click_on "Add comment"
      expect(page).to have_content("can't be blank")
    end

    it "creates comments and redirects to goal show page" do
      fill_in "comment_body", with: "good luck"
      click_on "Add comment"
      expect(page).to have_content("good luck")
    end
  end
end
