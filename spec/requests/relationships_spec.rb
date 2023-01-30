require 'rails_helper'

RSpec.describe "Relationships", type: :request do
    let(:user) { FactoryBot.create(:user) }
    let(:other) { FactoryBot.create(:archer) }

  describe "#create" do
    it "increase a relationship" do
      sign_in(user)
      expect {
        post relationships_path, params: { followed_id: other.id }
      }.to change(Relationship, :count).by 1
    end

    context "not logged in" do
      it "redirects to login_path" do
        post relationships_path
        expect(response).to redirect_to new_user_session_path
      end

      it "is not able to create" do
        expect {
          post relationships_path
        }.to_not change(Relationship, :count)
      end
    end
  end

  describe "#destroy" do
    it "decrase a relationship" do
      sign_in(user)
      user.follow(other)
      relationship = user.active_relationships.find_by(followed_id: other.id)
      expect {
        delete relationship_path(relationship)
      }.to change(Relationship, :count).by -1
    end
  end
end
