require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get signup_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /users #create" do
    it "is invalid signup information" do
      get signup_path
      expect {
        post users_path, params: { user: { name: "",
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
                                  password_confirmation: "password"} } }

    it "is saved" do
      expect {
        post users_path, params: user_params
      }.to change(User, :count).by 1
    end

    it "redirect to users/show" do
      post users_path, params: user_params
      user = User.last
      expect(response).to redirect_to user
    end

    it "shows a flash" do
      post users_path, params: user_params
      expect(flash).to be_any
    end
  end
end
