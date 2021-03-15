class Web::V1::VersionControlsController < ApplicationController
  before_action :set_version_control, only: [:show, :update, :destroy]

  # GET /web/v1/version_controls
  # GET /web/v1/version_controls.json
  def index
    @version_controls = VersionControl.all

    render json: @version_controls
  end

  # GET /web/v1/version_controls/1
  # GET /web/v1/version_controls/1.json
  def show
    render json: @version_control
  end

  # POST /web/v1/version_controls
  # POST /web/v1/version_controls.json
  def create
    @version_control = params[:version_control]
    @users = User.all

    if @version_control
      @users.each do |user|
        user.version_control.update(version_control_params) if user.version_control
      end
    else
      render json: @version_control.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/version_controls/1
  # PATCH/PUT /web/v1/version_controls/1.json
  def update
    @version_control = VersionControl.find(params[:id])

    if @version_control.update(version_control_params)
      head :no_content
    else
      render json: @version_control.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/version_controls/1
  # DELETE /web/v1/version_controls/1.json
  def destroy
    @version_control.destroy

    head :no_content
  end

  private

    def set_version_control
      @version_control = VersionControl.find(params[:id])
    end

    def version_control_params
      params.require(:version_control).permit(:user_id, :current_version, :latest_version, :allow_update, :force_update)
    end
end
