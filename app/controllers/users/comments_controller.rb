class Users::CommentsController < ApplicationController

  before_action :require_user, only: [:new, :create]

  def index
    @user = User.find(params[:user_id])
    @comments = @user.comments
  end
end