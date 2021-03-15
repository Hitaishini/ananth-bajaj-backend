class Web::V1::BikesController < ApplicationController
  #before_filter :authenticate_user!
  before_action :set_bike, only: [:show, :update, :destroy]

  # GET /web/v1/bikes
  # GET /web/v1/bikes.json
  def index
    @bikes = Bike.all.order("display_order")
    render json: @bikes.includes(:specifications)  #each_serializer: Web::V1::BikeSerializer
  end

  def get_all_bikes
     @bikes = Bike.where(visible: true).order("display_order")  #.includes(:specifications)
      render json: @bikes, each_serializer: Web::V1::BikeSerializer   
  end

  # GET /web/v1/bikes/1
  # GET /web/v1/bikes/1.json
  def show
    render json: @bike  #serializer: Web::V1::BikeSerializer
  end

  # POST /web/v1/bikes
  # POST /web/v1/bikes.json
  def create
    @bike = Bike.new(bike_params)
    @bike.compare_vehicles = params[:bike][:compare_vehicles]

    if @bike.save
      audit(@bike, current_user)
      render json: @bike, status: :created #serializer: Web::V1::BikeSerializer
    else
      render json: @bike.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/bikes/1
  # PATCH/PUT /web/v1/bikes/1.json
  def update
    @bike = Bike.find(params[:id])
    @bike.compare_vehicles = params[:bike][:compare_vehicles]

    if @bike.update(bike_params)
      audit(@bike, current_user)
      render json: @bike, status: :ok  #serializer: Web::V1::BikeSerializer
    else
      render json: @bike.errors, status: :unprocessable_entity
    end
  end

  #get non bajaj vehicles
  def get_non_bajaj_vehicles
    @bikes = Bike.where(non_bajaj: true).order("display_order")
    
    render json: @bikes
  end

  # DELETE /web/v1/bikes/1
  # DELETE /web/v1/bikes/1.json
  def destroy
    audit(@bike, current_user)
    @bike.destroy

    head :no_content
  end

  def delete_bikes
    @bikes = params[:bike_ids]
    @bikes.each do |bike_id|
      Bike.find(bike_id).delete
    end
  end

  private

  def set_bike
    @bike = Bike.find(params[:id])
  end

  def bike_params
    params.require(:bike).permit(:id, :brand, :bike_price, :total_price, :engine, :visible, :bike_cc, :name, :description, :bike_type_id, :available, :tagline, :display_order, :service_schedule_url ,:warranty_url, :bike_brochure_url, :non_bajaj, :compare_vehicles)
  end
end
