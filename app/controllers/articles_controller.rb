class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: %i[new show create destroy]
  before_action :correct_user, only: :destroy

  def new
    @article = current_user.articles.build
  end

  # def index
  #   @articles = current_user.articles.all
  #   @article = current_user.articles.new
  # end

  def show
    @article = Article.find(params[:id])
    @comments = @article.comments
    @comment = current_user.comments.new
  end

  def create
    @article = current_user.articles.build(article_params)
    @article.image.attach(params[:article][:image])
    if @article.save
      flash[:success] = "Article created!"
      redirect_to root_url
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    flash[:success] = "Article deleted"
    if request.referer.nil?
      redirect_to root_url, status: :see_other
    else
      redirect_to request.referer, status: :see_other
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
