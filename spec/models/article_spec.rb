require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:article) { user.articles.build(title: "Lorem", content: "Lorem ipsum") }

  it "is valid" do
    expect(article).to be_valid
  end

  it "is not invalid when id is nil" do
    article.user_id = nil
    expect(article).to_not be_valid
  end

  it "is right order which is most recent first" do
    FactoryBot.send(:user_with_posts)
    expect(FactoryBot.create(:most_recent)).to eq Article.first
  end

  it "removes user's articles when the user is destroy" do
    post = FactoryBot.create(:most_recent)
    user = post.user
    expect {
      user.destroy
    }.to change(Article, :count).by -1
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
