class Users::RoutesController < ApplicationController
  before_action :require_user_is_owner, only: :destroy

  def index
    @user = User.find(params[:user_id])
    @routes = @user.routes
    respond_to do |format|
      format.html
      format.json { render json: @routes, each_serializer: PartialRouteSerializer }
    end
  end

  def destroy
    @route = Route.find(params[:id])
    @route.destroy
    respond_to do |format|
      format.html { redirect_to user_routes_path(current_user), notice: 'Route has been deleted.' }
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