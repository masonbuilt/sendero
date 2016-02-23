class Users::CommentsController < ApplicationController

  before_action :require_user_is_owner, only: :destroy

  def index
    @user = User.find(params[:user_id])
    @comments = @user.comments.includes(:route).all
    respond_to do |format|
      format.html
      format.json { render json: @comments }
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to user_comments_path(current_user), notice: 'Comment has been removed.' }
      format.json { head :no_content }
    end
  end

  private

  def require_user_is_owner
    if current_user.id != params[:user_id].to_i
      flash[:notice] = "You are not authorized to perform this action"
      redirect_to root_path
    end
  end
end