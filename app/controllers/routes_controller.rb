class RoutesController < ApplicationController
  before_action :set_route, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_user_is_owner, only: [:edit, :update, :destroy]

  def index
    @routes = Route.includes(:grade).all.map {|r| PartialRouteSerializer.new(r, root: false)}
    respond_to do |format|
      format.html
      format.json { render json: @routes, root: false }
    end
  end

  def show
    @projects = @route.projects
    @grade    = @route.grade
    @comments = @route.comments
    respond_to do |format|
      format.html
      format.json { render json: @route }
    end
  end

  def search
    render :json => Route.search(params['term']), root: false
  end

  def new
    @route = Route.new
  end

  def edit
  end

  def create
    @route = Route.new(route_params.merge("owner_id" => current_user.id))
    
    respond_to do |format|
      if @route.save
        format.html { redirect_to @route, notice: 'Route was successfully created.' }
        format.json { render json: @route, status: :created }
      else
        format.html { render :new }
        format.json { render json: @route.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @route.update(route_params)
        format.html { redirect_to @route, notice: 'Route was successfully updated.' }
        format.json { render :show, status: :ok, location: @route }
      else
        format.html { render :edit }
        format.json { render json: @route.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @route.destroy
    respond_to do |format|
      format.html { redirect_to routes_url, notice: 'Route was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_route
    @route = Route.find(params[:id])
  end

  def require_user
    if current_user.nil?
      flash[:notice] = "You must be logged in to view this page"
      redirect_to routes_path
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def route_params
    params.require(:route).permit(:name, :grade_id, :owner_id, :info)
  end

  def require_user_is_owner
    if current_user != @route.owner
      flash[:notice] = "You are not authorized to perform this action"
      redirect_to routes_path
    end
  end
end
