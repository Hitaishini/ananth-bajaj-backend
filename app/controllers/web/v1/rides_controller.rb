class Web::V1::RidesController < ApplicationController
  before_action :set_ride, only: [:show, :update, :destroy]

  # GET /web/v1/rides
  # GET /web/v1/rides.json
  def index
    @rides = Ride.all.order("updated_at DESC").order("created_at DESC")

    render json: @rides
  end

  # GET /web/v1/rides/1
  # GET /web/v1/rides/1.json
  def show
    render json: @ride
  end

  # POST /web/v1/rides
  # POST /web/v1/rides.json
  def create
    @ride = Ride.new(ride_params)
    @ride.assembly_time = params[:ride][:assembly_time]
    @ride.destination_time = params[:ride][:destination_time]
    @ride.check_points = params[:ride][:check_points]
    if @ride.save
      @ride.delay.call_notification(I18n.t('Notification.ride_created'), I18n.t('Email.ride_created'))
      render json: @ride, status: :created
    else
      render json: @ride.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/rides/1
  # PATCH/PUT /web/v1/rides/1.json
  def update
    @ride = Ride.find(params[:id])
    if @ride.update(ride_params)
      @ride.update(assembly_time: params[:ride][:assembly_time])
      @ride.update(destination_time: params[:ride][:destination_time])
      @ride.update(check_points: params[:ride][:check_points])
      render json: @ride
      
      @ride.delay.call_notification(I18n.t('Notification.ride_updated'), I18n.t('Email.ride_updated'))
      #head :no_content

    else
      render json: @ride.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/rides/1
  # DELETE /web/v1/rides/1.json
  def destroy
    @destroyed = false
    begin  
      @ride.delay.call_notification(I18n.t('Notification.ride_deleted'), I18n.t('Email.ride_deleted'))
    rescue StandardError => e
      @destroyed = true
      @ride.destroy
    end
    @ride.destroy unless @destroyed
    head :no_content
  end

  def delete_rides
    @rides = params[:ride_ids]
    @rides.each do |ride|
      Ride.find(ride).destroy
    end
  end

  def user_inforamtion
    @user_rides = UserRide.where(ride_id: params[:ride_id])

    render json: @user_rides, root: "user_ride_information", each_serializer: Web::V1::UserInformationSerializer
  end

  private

  def set_ride
    @ride = Ride.find(params[:id])
  end

  def ride_params
    params.require(:ride).permit(:ride_date, :title, :check_points, :route, :distance, :assembly_time, :assembly_location, :destination_time, :destination_location, :notify, :coordinator_name, :coordinator_mobile)
  end

end
