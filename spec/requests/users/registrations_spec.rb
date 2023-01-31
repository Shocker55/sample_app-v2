require 'rails_helper'

RSpec.describe "User Registration", type: :request do
  describe "GET new_user_registration_path" do
    it "returns http success" do
      get new_user_registration_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET edit_user_registration_path" do
    let(:user) { FactoryBot.create(:user) }

    it "returns http success" do
      sign_in(user)

      get edit_user_registration_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST user_registration_path " do
    it "is invalid signup information" do
      expect {
        post user_registration_path, params: { user: { name: "",
                                           email: "user@invlid",
                                           password: "foo",
                                           password_confirmation: "bar" } }
      }.to_not change(User, :count)
    end
  end

  context "valid information" do
    let(:user_params) { { user: { name: "Example User",
                                  email: "user@exampe.com",
                                  password: "password",
                                  password_confirmation: "password" } } }

    it "is saved" do
      expect {
        post user_registration_path, params: user_params
      }.to change(User, :count).by 1
    end

    it "redirect to users/show" do
      post user_registration_path, params: user_params
      expect(response).to redirect_to root_url
    end

    it "shows a flash" do
      post user_registration_path params: user_params
      expect(flash).to be_any
    end

    # it "ログイン状態であること" do
    #   post user_registration_path, params: user_params
    #   expect(is_logged_in?).to be_truthy
    # end
  end

  describe "DELETE user_registration_path" do
    let(:user) { FactoryBot.create(:user) }

    it "creates a user" do
      sign_in(user)

      expect {
        delete user_registration_path
      }.to change(User, :count).by(-1)
    end
  end
end
