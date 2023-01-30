require "rails_helper"

RSpec.describe "Sessions", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "#new" do
    context "login with invalid information" do
      it "shows a flash message" do
        visit new_user_session_path
        fill_in "Eメール", with: ""
        fill_in "パスワード", with: ""
        click_button "ログイン"
        expect(page).to have_selector "p.alert"
      end
    end

    context "login with valid infromation" do
      let(:user) { FactoryBot.create(:user) }

      it "shows users page" do
        visit new_user_session_path
        fill_in "Eメール", with: user.email
        fill_in "パスワード", with: user.password
        click_button "ログイン"
        expect(page).to_not have_selector "a[href=\"#{new_user_session_path}\"]"
        expect(page).to have_selector "a[href=\"#{destroy_user_session_path}\"]"
        expect(page).to have_selector "a[href=\"#{user_path(user)}\"]"
      end
    end
  end
end
