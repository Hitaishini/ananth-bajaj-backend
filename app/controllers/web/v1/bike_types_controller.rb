class Web::V1::BikeTypesController < ApplicationController
  #before_filter :authenticate_user!
  before_action :set_bike_type, only: [:show, :update, :destroy]

  # GET /web/v1/bike_types
  # GET /web/v1/bike_types.json
  def index
    @bike_types = BikeType.all.order("updated_at DESC").order("created_at DESC")

    render json: @bike_types #each_serializer: Web::V1::BikeTypeSerializer
  end

  # GET /web/v1/bike_types/1
  # GET /web/v1/bike_types/1.json
  def show
    render json: @bike_type
  end

  # POST /web/v1/bike_types
  # POST /web/v1/bike_types.json
  def create
    @bike_type = BikeType.new(bike_type_params)

    if @bike_type.save
      audit(@bike_type, current_user)
      render json: @bike_type, status: :created
    else
      render json: @bike_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/bike_types/1
  # PATCH/PUT /web/v1/bike_types/1.json
  def update
    @bike_type = BikeType.find(params[:id])

    if @bike_type.update(bike_type_params)
      audit(@bike_type, current_user)
      render json: @bike_type, status: :ok
    else
      render json: @bike_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/bike_types/1
  # DELETE /web/v1/bike_types/1.json
  def destroy
    audit(@bike_type, current_user)
    @bike_type.destroy

    head :no_content
  end

  def delete_bike_types
    @bike_types = params[:bike_type_ids]
    @bike_types.each do |bike_type_id|
      BikeType.find(bike_type_id).delete
    end
  end

  private

    def set_bike_type
      @bike_type = BikeType.find(params[:id])
    end

    def bike_type_params
      params.require(:bike_type).permit(:name, :tagline, :available, :display_order)
    end
end
