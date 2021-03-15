class Web::V1::BikeColorsController < ApplicationController
  before_action :set_bike_color, only: [:show, :update, :destroy]

  # GET /web/v1/bike_colors
  # GET /web/v1/bike_colors.json
  def index
    @bike_colors = BikeColor.all.order("updated_at DESC").order("created_at DESC")

    render json: @bike_colors
  end

  # GET /web/v1/bike_colors/1
  # GET /web/v1/bike_colors/1.json
  def show
    render json: @bike_color
  end

  # POST /web/v1/bike_colors
  # POST /web/v1/bike_colors.json
  def create
    @bike_color = BikeColor.new(bike_color_params)

    if @bike_color.save
      audit(@bike_color, current_user)
      render json: @bike_color, status: :created
    else
      render json: @bike_color.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/bike_colors/1
  # PATCH/PUT /web/v1/bike_colors/1.json
  def update
    @bike_color = BikeColor.find(params[:id])

    if @bike_color.update(bike_color_params)
      audit(@bike_color, current_user)
      head :no_content
    else
      render json: @bike_color.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/bike_colors/1
  # DELETE /web/v1/bike_colors/1.json
  def destroy
    audit(@bike_color, current_user)
    @bike_color.destroy

    head :no_content
  end

  def delete_bike_colors
    @bike_colors = params[:bike_color_ids]
    @bike_colors.each do |bike_color|
      BikeColor.find(bike_color).delete
    end
  end

  private

  def set_bike_color
    @bike_color = BikeColor.find(params[:id])
  end

  def bike_color_params
    params.require(:bike_color).permit(:label, :color, :bike_id, :image, :color_pallet_s3, :compare_visible)
  end
end
