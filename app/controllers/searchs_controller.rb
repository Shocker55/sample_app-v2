class SearchsController < ApplicationController
  def search
    @model = params[:model]
    @content = params[:content]
    @records = search_for(@model, @content)
  end

  private
  def search_for(model, content)
    if model == 'user'
      if params["content"].present?
        @users = User.where('name LIKE ?', "%#{params[:content]}%")
      else
        @users = User.none
      end
    elsif model == 'article'
      if params["content"].present?
        @articles = Article.where('title LIKE ?', "%#{params[:content]}%")
      else
        @articles = Article.none
      end
    end
  end
end
