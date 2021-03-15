class Web::V1::ProfilesController < ApplicationController
  #before_filter :authenticate_user!
  before_action :set_profile, only: [:show, :update, :destroy]

  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all.order("updated_at DESC").order("created_at DESC")

    render json: @profiles, serializer: Web::V1::ProfileSerializer
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    render json: @profile, serializer: Web::V1::ProfileSerializer
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)

    if @profile.save
      render json: @profile, status: :created, location: [:web, @profile]
    else
      render json: @profile.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    @profile = Profile.find(params[:id])

    if @profile.update(profile_params)
      if params[:profile][:role] == "admin"
        @user = User.find_by_id(params[:profile][:user_id])
        @user.update(password: params[:profile][:password], password_confirmation: params[:profile][:confirmpassword])
      end
      render json: @profile, status: :ok, location: [:web, @profile]
    else
      render json: @profile.errors, status: :unprocessable_entity
    end
  end

  def profile_image_update
    @profile = Profile.find(params[:id])
    @profile.remove_profile_image! if @profile.profile_image
    if @profile.update(profile_params)
     @profile.profile_image = params[:profile][:profile_image]
     @profile.save
     render json: @profile, status: :ok
   else
    render json: @profile.errors, status: :unprocessable_entity
  end
end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy

    head :no_content
  end

  def delete_profiles
    @profiles = params[:profile_ids]
    @profiles.each do |profile_id|
      Profile.find(profile_id).delete
    end
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:full_name, :mobile, :dob, :email, :gender, :bike_owned, :riding_since, :address, :location, :profession, :bio, :hog_privacy, :profile_image, :user_id)
  end
end
