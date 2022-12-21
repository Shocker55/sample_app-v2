require 'rails_helper'

RSpec.describe "Layouts", type: :system, js: true do
  # before do
  #   driven_by(:selenium_chrome)
  # end

  let(:user) { FactoryBot.create(:user) }

  describe "header" do
    context "loging in" do
      before do
        log_in_as user
        visit root_path
      end

      it "redirects root when Title is clicked" do
        click_link "My Plants"
        expect(page.current_path).to eq root_path
      end

      it "redirects user index when Users is clicked" do
        click_link "Users"
        expect(page.current_path).to eq users_path
      end

      context "Account" do
        # before do
        #   click_link "Account"
        # end

        it "redirects user page when Profile is clicked" do
          click_link "Account"
          click_link "Profile"
          expect(page.current_path).to eq user_path(user)
        end

        it "redirects correct page when Settings is clicked" do
          click_link "Account"
          click_link "Settings"
          expect(page.current_path).to eq edit_user_path(user)
        end

        it "redirects root when Log out is clicked" do
          click_link "Account"
          click_link "Log out"
          expect(page.current_path).to eq root_path
        end
      end
    end

    context "not logging in" do
      before do
        visit root_path
      end

      it "redirects root when title is clicked" do
        click_link "My Plants"
        expect(page.current_path).to eq root_path
      end

      it "redirects login page when ログイン is clicked" do
        click_link "ログイン"
        expect(page.current_path).to eq login_path
      end

      it "redirects sign in when 新規作成 is clicked" do
        click_link "新規作成"
        expect(page.current_path).to eq signup_path
      end
    end
  end

  describe "footer" do
    before do
      visit root_path
    end

    it "redirects about when About is clicked" do
      click_link "About"
      expect(page.current_path).to eq about_path
    end

    it "redirects contact when Contact is clicked" do
      click_link "お問い合わせ"
      expect(page.current_path).to eq contact_path
    end
  end
end
