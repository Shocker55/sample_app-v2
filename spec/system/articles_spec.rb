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

    it "shows 30 articles" do
      visit user_path @user

      posts_wrapper =
        within "ol.articles" do
          find_all("li")
        end
      expect(posts_wrapper.size).to eq 30
    end

    it "has paginate articles" do
      visit user_path @user
      expect(page).to have_selector "ul.pagination"
    end

    it "has Article's title in a page" do
      visit user_path @user
      @user.articles.page(1).each do |article|
        expect(page).to have_content article.title
      end
    end

    it "has Article's content in a page" do
      visit user_path @user
      @user.articles.page(1).each do |article|
        expect(page).to have_content article.content
      end
    end
  end

  describe "home" do
    before do
      FactoryBot.send(:user_with_posts, posts_count: 35)
      @user = Article.first.user
      @user.password = "password"
      log_in_as @user
      visit root_url
    end

    it "has paginate articles" do
      expect(page).to have_selector "ul.pagination"
    end

    it "displays the right article count" do
      expect(page).to have_content "35 articles"
    end

    it "displays proper pluralization for zero articles or one article" do
      @user.articles.destroy_all
      visit current_path
      expect(page).to have_content "0 articles"

      fill_in "article_title", with: "Article Title"
      fill_in "article_content", with: "This article really ties the room together"
      click_button "Post"
      expect(page).to have_content "1 article"
    end

    # it '画像添付ができること' do
    #   expect {
    #     fill_in "article_title", with: "Article Title"
    #     fill_in "article_content", with: "This article really ties the room together"
    #     attach_file "article[image]", "#{Rails.root}/spec/files/kitten.jpg"
    #     click_button "Post"
    #   }.to change(Article, :count).by 1
    #   attached_post = Article.first
    #   expect(attached_post.image).to be_attached
    # end

    context "valid submission" do
      it "is able to post" do
        expect {
          fill_in "article_title", with: "Article Title"
          fill_in "article_content", with: "This article really ties the room together"
          click_button "Post"
        }.to change(Article, :count).by 1

        expect(page).to have_content "Article Title"
        expect(page).to have_content "This article really ties the room together"
      end
    end

    context "invalid submission" do
      it "is inable to post" do
        fill_in "article_title", with: ''
        fill_in "article_content", with: ''
        click_button "Post"

        expect(page).to have_selector "div#error_explanation"
      end
    end

    describe "delete" do
      it "has article delete links on own profile page" do
        expect(page).to have_link "delete"
      end

      it "is able to delete own article" do
        fill_in "article_title", with: "Article Title"
        fill_in "article_content", with: "This article really ties the room together"
        click_button "Post"

        post = Article.first

        expect {
          click_link "delete", href: article_path(post)
        }.to change(Article, :count).by -1
        expect(page).to_not have_content "Article Title"
        expect(page).to_not have_content "This article really ties the room together"
      end

      it "does not have dalete links on other user's profile page" do
        @other_user = FactoryBot.create(:archer)
        visit user_path(@other_user)
        expect(page).to_not have_link "delete"
      end
    end
  end
end
