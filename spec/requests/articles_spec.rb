require 'rails_helper'

RSpec.describe "Articles", type: :request do
  describe "GET #new" do
    let(:user) { FactoryBot.create(:user) }

    before do
      log_in_as user
    end

    it "returns http success" do
      get '/articles/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe "#create" do
    context "not logged in" do
      it "is not able to create when not logged in" do
        expect {
          post articles_path, params: { article: { title: "Lorem", content: "Lorem ipsum" } }
        }.to_not change(Article, :count)
      end

      it "redirect to login_path when not logged in" do
        post articles_path, params: { article: { title: "Lorem", content: "Lorem ipsum" } }
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "#destroy" do
    let(:user) { FactoryBot.create(:archer) }

    before do
      @post = FactoryBot.create(:most_recent)
    end

    context "not logged in" do
      it "is not able to destroy when not logged in" do
        expect {
          delete article_path(@post)
        }.to_not change(Article, :count)
      end

      it "redirect to login_path when not logged in" do
        delete article_path(@post)
        expect(response).to have_http_status :see_other
        expect(response).to redirect_to login_path
      end
    end

    context "delete other user's post" do
      before do
        log_in_as user
      end

      it "is enable" do
        expect {
          delete article_path(@post)
        }.to_not change(Article, :count)
      end

      it "redirect to login_path" do
        delete article_path(@post)
        expect(response).to have_http_status :see_other
        expect(response).to redirect_to root_url
      end
    end
  end
end
