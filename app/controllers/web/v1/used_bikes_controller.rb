class Web::V1::UsedBikesController < ApplicationController
  before_action :set_used_bike, only: [:show, :update, :destroy]

  # GET /web/v1/used_bikes
  # GET /web/v1/used_bikes.json
  def index
    @used_bikes = UsedBike.all

    render json: @used_bikes, each_serializer: Web::V1::UsedBikeSerializer
  end

  # GET /web/v1/used_bikes/1
  # GET /web/v1/used_bikes/1.json
  def show
    render json: @used_bike, serializer: Web::V1::UsedBikeSerializer
  end

  # POST /web/v1/used_bikes
  # POST /web/v1/used_bikes.json
  def create
    @used_bike = UsedBike.new(used_bike_params)

    if @used_bike.save
      adding_images(params)
      render json: @used_bike, status: :created, serializer: Web::V1::UsedBikeSerializer
    else
      render json: @used_bike.errors, status: :unprocessable_entity
    end
  end


  def adding_images(params)
   if params[:used_bike][:used_bike_images_attributes][0][:image]

           params[:used_bike][:used_bike_images_attributes][0][:image].each { |image|
                @used_bike.used_bike_images.create(image: image)
            } 
        end     
  end

  # PATCH/PUT /web/v1/used_bikes/1
  # PATCH/PUT /web/v1/used_bikes/1.json
  def update
    @used_bike = UsedBike.find(params[:id])

    if @used_bike.update(used_bike_params)
      adding_images(params)
      head :no_content
    else
      render json: @used_bike.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/used_bikes/1
  # DELETE /web/v1/used_bikes/1.json
  def destroy
    @used_bike.destroy

    head :no_content
  end

  def delete_used_bikes
     @banners = params[:used_bike_ids]
    @banners.each do |banner|
      UsedBike.find(banner).delete
    end
  end

  def delete_used_bike_image
    used_bike = UsedBike.find_by_id(params[:used_bike_id])
    used_bike.used_bike_images.find(params[:used_bike_image_id]).delete if used_bike
    head :no_content
  end

  private

    def set_used_bike
      @used_bike = UsedBike.find(params[:id])
    end

    def used_bike_params
      params.require(:used_bike).permit(:make_coompany, :model, :contact_number, :bike_variant, :status, :under_warrenty, :exchange, :dealer_id, :registration_number, :bike_type, :manufacture_year, :kms, :gear, :color, :ownership, :price, :for_sell, :used_bike_model_id, :user_id,  used_bike_images_attributes: [:image, :used_bike_id])
    end
end
