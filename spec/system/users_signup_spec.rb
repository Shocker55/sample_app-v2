require 'rails_helper'

RSpec.feature "UsersSignups", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "#create" do
    context "invalid signup information" do
      it "shows error explanations" do
        visit signup_path
        fill_in "Name", with: ""
        fill_in "Email", with: "user@invlid"
        fill_in "Password", with: "foo"
        fill_in "Password confirmation", with: "bar"
        click_button "Create my account"

        expect(page).to have_selector "div#error_explanation"
        expect(page).to have_selector "div.field_with_errors"
      end
    end
  end
end
