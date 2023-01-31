require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get new_user_session_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST user_session_path" do
    let(:user) { FactoryBot.create(:user) }
    let(:user_attributes) { { email: user.email, password: user.password } }

    it "signs in a user" do
      post user_session_path, params: { user: user_attributes }
      follow_redirect!
      expect(response.body).to include("ログインしました。")
    end
  end

  describe "DELETE destroy_user_session_path" do
    let(:user) { FactoryBot.build(:user) }

    it 'signs the user out' do
      sign_in(user)

      delete destroy_user_session_path
      follow_redirect!
      expect(response.body).to include("ログアウトしました。")
      expect(response.body).to include("ログイン")
    end
  end

  #   describe "#create" do
  #     let(:user) { FactoryBot.create(:user) }

  #     describe "remember me " do
  #       it "has cookies[:remember_token] when it's ON" do
  #         log_in_as(user, remember_me: '1')
  #         expect(cookies[:remember_token]).to_not be_blank
  #       end

  #       it "doesn't have cookies[:remember_token] when it's OFF" do
  #         log_in_as(user, remember_me: '1')
  #         log_in_as(user, remember_me: '0')
  #         expect(cookies[:remember_token]).to be_blank
  #       end
  #     end
  #   end
end
