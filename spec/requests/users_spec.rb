require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "Get /users" do
    it "redirects index when not logged in" do
      get users_path
      expect(response).to redirect_to new_user_session_path
    end

    describe "pagination" do
      let(:user) { FactoryBot.create(:archer) }
      before do
        30.times do
          FactoryBot.create(:continuous_users)
        end
        sign_in(user)
        get users_path
      end

      it 'div.paginationが存在すること' do
        expect(response.body).to include '<ul class="pagination">'
      end

      it 'ユーザごとのリンクが存在すること' do
        User.page(1).each do |user|
          expect(response.body).to include "<a href=\"#{user_path(user)}\">"
        end
      end
    end
  end

  describe "Get /users/edit" do
    let(:user) { FactoryBot.create(:user) }

    context "not logged in" do
      it "redirects edit when not logged in" do
        get edit_user_registration_path
        expect(flash).to_not be_empty
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "Patch /users" do
    let(:user) { FactoryBot.create(:user) }
    let(:other_user) { FactoryBot.create(:archer) }

    it "is not allowed to be edited the admin attribute" do
      sign_in(other_user)
      expect(other_user).to_not be_admin

      patch user_registration_path, params: { user: { password: "password",
                                               password_confirmation: "pasword",
                                               admin: true } }
      other_user.reload
      expect(other_user).to_not be_admin
    end
  end

  describe "GET /users/{id}/followinig" do
    let(:user) { FactoryBot.create(:user) }

    it "redirects to login_path when not logged in" do
      get following_user_path(user)
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "GET /users/{id}/followers" do
    let(:user) { FactoryBot.create(:user) }

    it "redirects to login_path when not logged in" do
      get followers_user_path(user)
      expect(response).to redirect_to new_user_session_path
    end
  end
end
