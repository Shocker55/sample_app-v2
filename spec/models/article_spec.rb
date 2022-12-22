require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:article) { Article.new(title: "Lorem", content: "Lorem ipsum", user_id: user.id) }

  it "is valid" do
    expect(article).to be_valid
  end

  it "is not invalid when id is nil" do
    article.user_id = nil
    expect(article).to_not be_valid
  end

  describe "title" do
    it "is invalid when title is empty" do
      article.title = "   "
      expect(article).to_not be_valid
    end

    it "doesn't have over 51 characters" do
      article.title = "a" * 51
      expect(article).to_not be_valid
    end
  end

  describe "content" do
    it "is invalid when content is empty" do
      article.title = "   "
      expect(article).to_not be_valid
    end

    # it "doesn't have over 3001 characters" do
    #   article.title = "a" * 3001
    #   expect(article).to_not be_valid
    # end
  end
end
