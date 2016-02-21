class CommentsController < ApplicationController

	before_action :set_route
  before_action :set_comment, only: :destroy
  before_action :require_user, except: [:index, :show]
  before_action :require_user_is_owner, only: :destroy

  def index
    @comments = @route.comments
  end

  def new
  	@comment = Comment.new
  end

  def create
  	@comment = Comment.new(comment_params)
  	@comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to route_path(@route), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: route_comment_path(@route, @comment) }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @route, notice: 'Comment has been removed.' }
      format.json { head :no_content }
    end
  end

  private

  def comment_params
  	params.require(:comment).permit(:route_id, :body)
  end

  def require_user
    if current_user.nil?
      flash[:notice] = "You must be logged in to view this page"
      redirect_to root_path
    end
  end

  def set_route
  	@route = Route.find(params[:route_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def require_user_is_owner
    if @comment.user.id != params[:user_id].to_i
      flash[:notice] = "You are not authorized to perform this action"
      redirect_to root_path
    end
  end
end