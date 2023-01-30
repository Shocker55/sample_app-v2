require 'rails_helper'

RSpec.describe "Followings", type: :system do
  before do
    driven_by(:rack_test)
    @user = FactoryBot.send(:create_relationships)
    sign_in(@user)
  end

  describe "following page" do
    it "has following number and a link to following user" do
      visit following_user_path(@user)
      expect(@user.following).to_not be_empty
      expect(page).to have_content "10 following"
      @user.following.each do |user|
        expect(page).to have_link user.name, href: user_path(user)
      end
    end
  end

  describe "followers page" do
    it "has followers number and a link to followers user" do
      visit followers_user_path(@user)
      expect(@user.followers).to_not be_empty
      expect(page).to have_content "10 following"
      @user.followers.each do |user|
        expect(page).to have_link user.name, href: user_path(user)
      end
    end
  end
end
