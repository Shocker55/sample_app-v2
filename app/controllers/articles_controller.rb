class ArticlesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @article = current_user.articles.build(article_params)
    @article.image.attach(params[:article][:image])
    if @article.save
      flash[:success] = "Article created!"
      redirect_to root_url
    else
      @feed_items = current_user.feed.page(params[:page])
      render 'static_pages/home', status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    flash[:success] = "Article deleted"
    if request.referrer.nil?
      redirect_to root_url, status: :see_other
    else
      redirect_to request.referrer, status: :see_other
    end
  end

  private

    def article_params
      params.require(:article).permit(:title, :content, :image)
    end

    def correct_user
        @article = current_user.articles.find_by(id: params[:id])
        redirect_to root_url, status: :see_other if @article.nil?
    end
end

