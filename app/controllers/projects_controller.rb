class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :admit_user, :remove_access]
  before_action :authenticate_user!
  before_action :require_permission, only: [:edit, :update, :destroy, :admit_user, :remove_access]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @team = Team.find(params[:team_id])
    @project = Project.new
    @back_url = session[:previous_url] || @team
  end

  # GET /projects/1/edit
  def edit
    @team = @project.team
    @back_url = session[:previous_url] || @project
  end

  # PUT /projects/1/admit_user
  def admit_user
    if params[:user_id]
      user = User.find(params[:user_id])
      @project.users << user
    end
    redirect_back(fallback_location: @project)
  end

  # PUT /projects/1/remove_access/1
  def remove_access
    @project.accesses.where(user_id: params[:user_id])
      .first.destroy
    redirect_back(fallback_location: @project)
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @project.owner = current_user

    respond_to do |format|
      if @project.save
        @project.users << current_user
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
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
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
    team = @project.team
    @project.destroy
    respond_to do |format|
      format.html { redirect_to team, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :team_id)
    end

    def require_permission
      unless @project.owner == current_user
        redirect_back fallback_location: teams_url
      end
    end
end
