class Users::ProjectsController < ApplicationController
  before_action :require_user_is_owner, only: :destroy

  def index
    @user = User.find(params[:user_id])
    @projects = @user.projects
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    respond_to do |format|
      format.html { redirect_to user_projects_path(current_user), notice: 'Project has been deleted.' }
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