class StaticPagesController < ApplicationController
  def top; end

  def home
    if user_signed_in?
      @article = current_user.articles.build
      @feed_items = current_user.feed.page(params[:page]).per(30)
      @comments = Comment.where(article_id: current_user.articles.ids)
    end
  end

  def help; end

  def about; end

  def contact; end
end
