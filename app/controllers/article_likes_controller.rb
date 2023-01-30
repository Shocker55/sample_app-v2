class ArticleLikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @article = Article.find(params[:article_id])
    unless @article.iine?(current_user)
      @article.iine(current_user)
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
      end
  end

  def destroy
    @article = ArticleLike.find(params[:id]).article
    if @article.iine?(current_user)
      @article.uniine(current_user)
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url , status: :see_other}
        format.js
      end
    end
  end
end
