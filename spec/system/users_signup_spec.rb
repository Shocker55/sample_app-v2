require 'rails_helper'

RSpec.feature "UsersSignups", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "#create" do
    context "invalid signup information" do
      it "shows error explanations" do
        visit new_user_registration_path
        fill_in "Name", with: ""
        fill_in "Eメール", with: "user@invlid"
        fill_in "パスワード", with: "foo"
        fill_in "パスワード（確認用）", with: "bar"
        click_button "アカウント登録"

        expect(page).to have_selector "div#error_explanation"
        expect(page).to have_selector "div.field_with_errors"
      end
    end
  end
end
