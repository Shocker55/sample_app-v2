class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: :destroy

  def create
    @comment = current_user.comments.create(comment_params)
    redirect_to request.referer || root_url
  end

  def destroy
    @comment.destroy
    redirect_to request.referer || root_url, status: :see_other
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_content, :article_id)
  end

  def correct_user
    @comment = current_user.comments.find_by(id: params[:id], article_id: params[:article_id])
    redirect_to root_url, status: :see_other if @comment.nil?
  end
end
