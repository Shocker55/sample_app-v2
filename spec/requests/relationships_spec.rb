require 'rails_helper'

RSpec.describe "Relationships", type: :request do
  describe "#create" do
    context "not logged in" do
      it "redirects to login_path" do
        post relationships_path
        expect(response).to redirect_to login_url
      end

      it "is not able to create" do
        expect {
          post relationships_path
        }.to_not change(Relationship, :count)
      end
    end
  end
end
