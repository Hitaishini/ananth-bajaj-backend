class Website::WebCarColorsController < ApplicationController
  skip_before_filter :authenticate_user!
  before_action :set_web_car_color, only: [:show, :update, :destroy]

  # GET /web/v1/web_car_colors
  # GET /web/v1/web_car_colors.json
  def index
    @web_car_colors = WebCarColor.all

    render json: @web_car_colors
  end

  # GET /web/v1/web_car_colors/1
  # GET /web/v1/web_car_colors/1.json
  def show
    render json: @web_car_color
  end

  # POST /web/v1/web_car_colors
  # POST /web/v1/web_car_colors.json
  def create
    @web_car_color = WebCarColor.new(web_car_color_params)
    @web_car_color.s3_image_url = params[:web_car_color][:s3_image_url]
    @web_car_color.s3_pallet_image_url = params[:web_car_color][:s3_pallet_image_url]

    if @web_car_color.save
      render json: @web_car_color, status: :created
    else
      render json: @web_car_color.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/web_car_colors/1
  # PATCH/PUT /web/v1/web_car_colors/1.json
  def update
    @web_car_color = WebCarColor.find(params[:id])

    if @web_car_color.update(web_car_color_params)
      @web_car_color.update(s3_image_url: params[:web_car_color][:s3_image_url])
      @web_car_color.update(s3_pallet_image_url: params[:web_car_color][:s3_pallet_image_url])

      head :no_content
    else
      render json: @web_car_color.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/web_car_colors/1
  # DELETE /web/v1/web_car_colors/1.json
  def destroy
    @web_car_color.destroy

    head :no_content
  end

  private

  def set_web_car_color
    @web_car_color = WebCarColor.find(params[:id])
  end

  def web_car_color_params
    params.require(:web_car_color).permit(:car_id, :s3_image_url, :s3_pallet_image_url, :color_name)
  end
end
