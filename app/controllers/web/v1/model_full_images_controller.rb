class Web::V1::ModelFullImagesController < ApplicationController
  before_action :set_model_full_image, only: [:show, :update, :destroy]

  # GET /web/v1/model_full_images
  # GET /web/v1/model_full_images.json
  def index
    @model_full_images = ModelFullImage.all.order("updated_at DESC")

    render json: @model_full_images
  end

  # GET /web/v1/model_full_images/1
  # GET /web/v1/model_full_images/1.json
  def show
    render json: @model_full_image
  end

  # POST /web/v1/model_full_images
  # POST /web/v1/model_full_images.json
  def create
    @model_full_image = ModelFullImage.new(model_full_image_params)
    @model_full_image.image = params[:model_full_image][:image] 
    @model_full_image.video_url = params[:model_full_image][:video_url] 

    if @model_full_image.save
      render json: @model_full_image, status: :created
    else
      render json: @model_full_image.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/model_full_images/1
  # PATCH/PUT /web/v1/model_full_images/1.json
  def update
    @model_full_image = ModelFullImage.find(params[:id])
    @model_full_image.image = params[:model_full_image][:image] 
    @model_full_image.video_url = params[:model_full_image][:video_url] 

    if @model_full_image.update(model_full_image_params)
      head :no_content
    else
      render json: @model_full_image.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/model_full_images/1
  # DELETE /web/v1/model_full_images/1.json
  def destroy
    @model_full_image.destroy

    head :no_content
  end

  def delete_all_full_images
    @full_images = params[:full_image_ids]
    @full_images.each do |img|
      ModelFullImage.find(img).delete
    end
  end

  private

    def set_model_full_image
      @model_full_image = ModelFullImage.find(params[:id])
    end

    def model_full_image_params
      params.require(:model_full_image).permit(:image, :bike_id, :video_url, :category, :color_name)
    end
end
