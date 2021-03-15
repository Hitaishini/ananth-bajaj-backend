class Web::V1::WebCarGalleriesController < ApplicationController
  before_action :set_web_car_gallery, only: [:show, :update, :destroy]

  # GET /web/v1/web_car_galleries
  # GET /web/v1/web_car_galleries.json
  def index
    @web_car_galleries = WebCarGallery.all

    render json: @web_car_galleries
  end

  # GET /web/v1/web_car_galleries/1
  # GET /web/v1/web_car_galleries/1.json
  def show
    render json: @web_car_gallery
  end

  # POST /web/v1/web_car_galleries
  # POST /web/v1/web_car_galleries.json
  def create
    @web_car_gallery = WebCarGallery.new(web_car_gallery_params)
     @web_car_gallery.image_url = params[:web_car_gallery][:image_url]
     @web_car_gallery.diff_int_ext = params[:web_car_gallery][:diff_int_ext]

    if @web_car_gallery.save
      render json: @web_car_gallery, status: :created
    else
      render json: @web_car_gallery.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/web_car_galleries/1
  # PATCH/PUT /web/v1/web_car_galleries/1.json
  def update
    @web_car_gallery = WebCarGallery.find(params[:id])

    if @web_car_gallery.update(web_car_gallery_params)
      @web_car_gallery.update(image_url: params[:web_car_gallery][:image_url])
     @web_car_gallery.update(diff_int_ext: params[:web_car_gallery][:diff_int_ext])
      head :no_content
    else
      render json: @web_car_gallery.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/web_car_galleries/1
  # DELETE /web/v1/web_car_galleries/1.json
  def destroy
    @web_car_gallery.destroy

    head :no_content
  end

  def delete_web_car_galleries
    @web_car_galleries = params[:web_car_gallerie_ids]
   @web_car_galleries.each do |acc|
    WebCarGallery.find(acc).destroy
  end
  head :no_content 
end

private

def set_web_car_gallery
  @web_car_gallery = WebCarGallery.find(params[:id])
end

def web_car_gallery_params
  params.require(:web_car_gallery).permit(:car_id, :image_url, :diff_int_ext)
end
end
