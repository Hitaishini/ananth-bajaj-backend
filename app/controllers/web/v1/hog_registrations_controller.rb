class Web::V1::HogRegistrationsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_hog_registration, only: [:show, :update, :destroy]

  # GET /hog_registrations
  # GET /hog_registrations.json
  def index
    @hog_registrations = HogRegistration.all.order("updated_at DESC").order("created_at DESC")

    render json: @hog_registrations
  end

  # GET /hog_registrations/1
  # GET /hog_registrations/1.json
  def show
    render json: @hog_registration
  end

  # POST /hog_registrations
  # POST /hog_registrations.json
  def create
    @hog_registration = HogRegistration.new(hog_registration_params)

    if @hog_registration.save
      render json: @hog_registration, status: :created, location: [:web, @hog_registration]
    else
      render json: @hog_registration.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /hog_registrations/1
  # PATCH/PUT /hog_registrations/1.json
  def update
    @hog_registration = HogRegistration.find(params[:id])

    if @hog_registration.update(hog_registration_params)
      Profile.find_by(:user_id => params[:hog_registration][:user_id]).update(hog_registration_params)
      render json: @hog_registration, status: :ok, location: [:web, @hog_registration]
    else
      render json: @hog_registration.errors, status: :unprocessable_entity
    end
  end

  def hog_registration_image_update
    @hog_registration = HogRegistration.find(params[:id])
     @hog_registration.remove_profile_image! if @hog_registration.profile_image

    if @hog_registration.update(hog_registration_params)
      @hog_registration.profile_image = params[:hog_registration][:profile_image]
       @hog_registration.save
      render json: @hog_registration
      #head :no_content
    else
      render json: @hog_registration.errors, status: :unprocessable_entity
    end
  end

  # DELETE /hog_registrations/1
  # DELETE /hog_registrations/1.json
  def destroy
    @hog_registration.destroy

    head :no_content
  end

  def delete_hog_registrations
    @hog_registrations = params[:hog_registration_ids]
    @hog_registrations.each do |hog_registration|
      HogRegistration.find(hog_registration).delete
    end
  end

  private

    def set_hog_registration
      @hog_registration = HogRegistration.find(params[:id])
    end

    def hog_registration_params
      params.require(:hog_registration).permit(:full_name, :mobile, :email, :dob, :show_hog, :gender, :bike_owned, :riding_since, :address, :location, :profession, :bio, :hog_privacy, :profile_image, :user_id)
    end
end
