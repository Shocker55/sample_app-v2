require 'rails_helper'

RSpec.describe "Settings", type: :system do
  describe "profile settings" do
    let(:user) { FactoryBot.create(:user) }

    it "is invalid" do
      sign_in(user)

      visit edit_user_registration_path
      fill_in "Name", with: "invlid"
      fill_in "Eメール", with: "@invlid"
      fill_in "パスワード", with: "foo"
      fill_in "パスワード（確認用）", with: "foo"
      fill_in "現在のパスワード", with: "foo"
      click_button "更新"
      expect(page).to have_selector "div#error_explanation"
    end

    it "is valid" do
      sign_in(user)

      visit edit_user_registration_path
      fill_in "Name", with: "bob"
      fill_in "Eメール", with: "bob@example.com"
      fill_in "パスワード", with: "password"
      fill_in "パスワード（確認用）", with: "password"
      fill_in "現在のパスワード", with: user.password
      click_button "更新"
      expect(page).not_to have_selector "div#error_explanation"
    end
  end
end
