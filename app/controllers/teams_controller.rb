class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy, :accept_user_join, :remove_team_user, :add_member]
  before_action :authenticate_user!
  before_action :require_permission, only: [:edit, :update, :destroy, :accept_user_join, :remove_team_user, :add_member]

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
    @back_url = session[:previous_url] || teams_path
  end

  # GET /teams/1/edit
  def edit
    @back_url = session[:previous_url] || @team
  end

  # PUT /teams/1/accept_user/1
  def accept_user_join
    @team.team_users.where(user_id: params[:user_id])
      .first
      .update_attribute(:accepted, true)
    redirect_back(fallback_location: @team)
  end

  # DELETE /teams/1/remove_user/1
  def remove_team_user
    @team.team_users.where(user_id: params[:user_id])
      .first.destroy
    redirect_back(fallback_location: @team)
  end

  # PUT /teams/1/add_member
  def add_member
    if params[:user_id]
      user = User.find(params[:user_id])
      @team.add_member user
    end
    redirect_back(fallback_location: @team)
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)
    @team.owner = current_user

    respond_to do |format|
      if @team.save
        @team.add_member current_user
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: teams_path, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name)
    end

    # Check current user permission
    def require_permission
      unless @team.owner == current_user
        redirect_back fallback_location: teams_url
      end
    end
end
