require 'rails_helper'
 
RSpec.describe "Articles", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "Users#show" do
    before do
      FactoryBot.send(:user_with_posts, posts_count: 35)
      @user = Article.first.user
    end

    it "30件表示されていること" do
      visit user_path @user

      posts_wrapper =
        within "ol.articles" do
          find_all("li")
        end
      expect(posts_wrapper.size).to eq 30
    end

    it "ページネーションのラッパータグが表示されていること" do
      visit user_path @user
      expect(page).to have_selector "ul.pagination"
    end

    it "Articleの本文がページ内に表示されていること" do
      visit user_path @user
      @user.articles.page(1).each do |article|
        expect(page).to have_content article.content
      end
    end
  end
end