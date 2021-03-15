class Website::UsedBikesController < ApplicationController
  before_action :set_used_bike, only: [:show]
  skip_before_filter :authenticate_user!

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

   def create
    @used_bike = UsedBike.new(used_bike_params)

    if @used_bike.save
      sell_bike_validation(params)
      render json: @used_bike, status: :created
    else
      render json: @used_bike.errors, status: :unprocessable_entity
    end
  end

  def sell_bike_validation(params)
    if params[:used_bike][:sell_bike] == true
        @used_bike.update(for_sell: true)
        @used_bike.sell_bike_notify(I18n.t('Notification.sell_bike_msg'), I18n.t('Email.sell_bike_dealer_mail'), I18n.t('Email.sell_bike_user_mail'), params)
      end
  end

  #for fileter data
  def used_bike_filter_data
    @used_bike = UsedBike.filter_data
      render json: @used_bike
  end

  #forfilter
  def filter
    used_bikes = UsedBike.search(params)
    @used_bike = used_bikes.collect { |bike| bike.attributes.merge({ used_bike_images: bike.used_bike_images}) if bike }
    
    render json: @used_bike
  end

   private

    def set_used_bike
      @used_bike = UsedBike.find(params[:id])
    end

    def used_bike_params
      params.require(:used_bike).permit(:make_coompany, :model, :contact_number, :bike_variant, :exchange, :status, :dealer_id, :registration_number, :bike_type, :manufacture_year, :kms, :gear, :color, :ownership, :price, :for_sell, :used_bike_model_id, :user_id,  used_bike_images_attributes: [:image, :used_bike_id])
    end

end
