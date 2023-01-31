class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :following, :followers]

  def index
    @users = User.page(params[:page]).per(30)
  end

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.page(params[:page]).per(30)
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.page(params[:page]).per(30)
    render 'show_follow', status: :unprocessable_entity
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(30)
    render 'show_follow', status: :unprocessable_entity
  end
end
