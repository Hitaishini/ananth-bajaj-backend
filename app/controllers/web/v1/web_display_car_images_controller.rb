class Web::V1::WebDisplayCarImagesController < ApplicationController
  before_action :se_web_display_car_image, only: [:show, :update, :destroy]

  # GET /web/v1/web_display_car_images
  # GET /web/v1/web_display_car_images.json
  def index
   @web_display_car_images = WebDisplayCarImage.all

    render json:@web_display_car_images
  end

  # GET /web/v1/web_display_car_images/1
  # GET /web/v1/web_display_car_images/1.json
  def show
    render json:@web_display_car_image
  end

  # POST /web/v1/web_display_car_images
  # POST /web/v1/web_display_car_images.json
  def create
   @web_display_car_image = WebDisplayCarImage.new(web_display_car_image_params)

    if@web_display_car_image.save
      render json:@web_display_car_image, status: :created
    else
      render json:@web_display_car_image.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/web_display_car_images/1
  # PATCH/PUT /web/v1/web_display_car_images/1.json
  def update
   @web_display_car_image = WebDisplayCarImage.find(params[:id])

    if@web_display_car_image.update(web_display_car_image_params)
      head :no_content
    else
      render json:@web_display_car_image.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/web_display_car_images/1
  # DELETE /web/v1/web_display_car_images/1.json
  def destroy
   @web_display_car_image.destroy

    head :no_content
  end

  def delete_display_car_images
    @display_car_images = params[:display_car_image_ids]
    @display_car_images.each do |acc|
      WebDisplayCarImage.find(acc).destroy
    end
    head :no_content 
  end

  private

    def se_web_display_car_image
     @web_display_car_image = WebDisplayCarImage.find(params[:id])
    end

    def web_display_car_image_params
      params.require(:web_display_car_image).permit(:image_url, :car_id, :image)
    end
end
