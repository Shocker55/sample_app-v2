class StaticPagesController < ApplicationController
  def top
  end

  def home
    @article = current_user.articles.build if logged_in?
  end

  def help
  end

  def about
  end

  def contact
  end
end
