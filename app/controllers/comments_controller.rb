class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: :destroy

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @comment.destroy
    if request.referer.nil?
      redirect_to root_url, status: :see_other
    else
      redirect_to request.referer, status: :see_other
    end
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
