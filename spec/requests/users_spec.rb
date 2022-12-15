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
                                  password_confirmation: "password" } } }

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

    it "ログイン状態であること" do
      post users_path, params: user_params
      expect(is_logged_in?).to be_truthy
    end
  end

  describe "Get /users/{id}/edit" do
    let(:user) { FactoryBot.create(:user) }

    it "returns http success" do
      log_in_as user
      get edit_user_path(user)
      expect(response).to have_http_status(:success)
    end

    it "redirects edit when not logged in" do
      get edit_user_path(user)
      expect(flash).to_not be_empty
      expect(response).to redirect_to login_path
    end

    context "wrong user" do
      let(:other_user) { FactoryBot.create(:archer) }

      it "redirects edit whne logged in as wrong user" do
        log_in_as other_user
        get edit_user_path(user)
        expect(flash).to be_empty
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "Patch /users" do
    let(:user) { FactoryBot.create(:user) }

    it "redirects update when not logged in" do
      patch user_path(user)
      expect(flash).to_not be_empty
      expect(response).to redirect_to login_path
    end

    context "wrong user" do
      let(:other_user) { FactoryBot.create(:archer) }

      it "redirects edit whne logged in as wrong user" do
        log_in_as other_user
        get edit_user_path(user)
        patch user_path(user), params: { user: { name: user.name,
                                                       email: user.email } }
        expect(flash).to be_empty
        expect(response).to redirect_to root_path
      end
    end

    context "invalid information" do
      before do
        log_in_as user
        patch user_path(user), params: { user: { name: "",
                                                 email: "user@invlid",
                                                 password: "foo",
                                                 password_confirmation: "bar" } }
      end

      it "is enable to update" do
        user.reload
        expect(user.name).to_not eq ""
        expect(user.email).to_not eq ""
        expect(user.password).to_not eq "foo"
        expect(user.password_confirmation).to_not eq "bar"
      end

      it "renders an edit page after reloading" do
        expect(response.body).to include "<title>Edit user</title>"
      end

      it "shows errors" do
        expect(response.body).to include "The form contains 4 errors"
      end
    end

    context "valid information" do
      before do
        log_in_as user
        @name = "Foo Bar"
        @email = "foo@bar.com"
        patch user_path(user), params: { user: { name: @name,
                                                 email: @email,
                                                 password: '',
                                                 password_confirmation: '' } }
      end

      it "is able to update" do
        user.reload
        expect(user.name).to eq @name
        expect(user.email).to eq @email
      end

      it "redirects to Users#show" do
        expect(response).to redirect_to user
      end

      it "show a flash" do
        expect(flash).to be_any
      end
    end
  end
end
