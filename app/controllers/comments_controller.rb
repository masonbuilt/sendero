class CommentsController < ApplicationController

	before_action :set_route

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
end