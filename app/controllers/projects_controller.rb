class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :require_user_is_owner, only: [:edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    respond_to do |format|
      format.html
      format.json do
        render json: Project.all, each_serializer: PartialProjectSerializer, root: false
      end
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @user = @project.user
    @route = @project.route
    @grade = @route.grade
    respond_to do |format|
      format.html
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to projects_url, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    def require_user
      if current_user.nil?
        flash[:notice] = "You must be logged in to view this page"
        redirect_to root_path
      end
    end

    def require_user_is_owner
      if current_user != @project.user
        flash[:notice] = "You are not authorized to perform this action"
        redirect_to projects_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:user_id, :route_id, :status)
    end
end
