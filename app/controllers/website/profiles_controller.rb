class Website::ProfilesController < ApplicationController
  #before_filter :authenticate_user!
  before_action :set_profile, only: [:show, :update, :destroy, :update_profile_image]


  # GET /profiles/1
  # GET /profiles/1.json
  def show
    render json: @profile
  end

  # POST /profiles
  # POST /profiles.json
  # def create
  #   @profile = Profile.new(profile_params)

  #   if @profile.save
  #     render json: @profile, status: :created, location: @profile
  #   else
  #     render json: @profile.errors, status: :unprocessable_entity
  #   end
  # end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update

    if @profile.update(profile_params)
      #current_user.hog_registration.update(profile_params.except(:marriage_anniversary_date))
      update_user(@profile)
      render json: @profile, status: :ok
    else
      render json: @profile.errors, status: :unprocessable_entity
    end
  end

  def update_profile_image
   @profile.remove_profile_image! if @profile.profile_image
   if @profile.update(profile_params)
     @profile.profile_image = params[:profile][:profile_image]
     @profile.save
     render json: @profile, status: :ok
   else
    render json: @profile.errors, status: :unprocessable_entity
  end
end

def update_user(profile)
  @user = profile.try(:user)
  if @user.present?
    @user.update(email: profile.email)
  end
end

def update_notifications
  user = User.find_by_id(params[:id])
  @user_profile = user.profile
  @user_profile.update(notifiable_bookings: params[:booking_notification], notifiable_accessories:  params[:wishlist_notification], notifiable_offers:  params[:offer_notification], notifiable_tips: params[:tips_notification])
    #@user_profile.reload
    render json: @user_profile
  end



  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy

    head :no_content
  end

  private

  def set_profile
    user = User.where(authentication_token: params["auth_token"]).first
    logger.info "=====#{user.inspect}======auth token user===="
    @profile = user.profile
  end

  def profile_params
    params.require(:profile).permit(:full_name, :mobile, :email, :dob, :gender, :bike_owned, :riding_since, :address, :location, :profession, :bio, :hog_privacy, :profile_image, :user_id, :marriage_anniversary_date, :notifiable_offers, :notifiable_events, :notifiable_bookings, :notifiable_accessories, :notifiable_tips)
  end
end
