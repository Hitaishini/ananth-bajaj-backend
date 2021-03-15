class Web::V1::GalleriesController < ApplicationController
  before_action :set_gallery, only: [:show, :update, :destroy]

  # GET /web/v1/galleries
  # GET /web/v1/galleries.json
  def index
    @galleries = Gallery.all

    render json: @galleries, each_serializer: Web::V1::GallerySerializer
  end

  # GET /web/v1/galleries/1
  # GET /web/v1/galleries/1.json
  def show
    render json: @gallery, serializer: Web::V1::GallerySerializer
  end

  # POST /web/v1/galleries
  # POST /web/v1/galleries.json
  def create
    @gallery = Gallery.new(gallery_params)
    @gallery.image = params[:gallery][:image]

    if @gallery.save
      audit(@gallery, current_user)
      render json: @gallery, status: :created, serializer: Web::V1::GallerySerializer
    else
      render json: @gallery.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/galleries/1
  # PATCH/PUT /web/v1/galleries/1.json
  def update
    @gallery = Gallery.find(params[:id])

    if @gallery.update(gallery_params)
      audit(@gallery, current_user)
      @gallery.update(image: params[:gallery][:image])
      #render json: @gallery
      head :no_content
    else
      render json: @gallery.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/galleries/1
  # DELETE /web/v1/galleries/1.json
  def destroy
    audit(@gallery, current_user)
    @gallery.destroy

    head :no_content
  end

  def delete_galleries
   @galleries = params[:gallary_ids]
   @galleries.each do |gallery|
    Gallery.find(gallery).destroy
  end
end

private

def set_gallery
  @gallery = Gallery.find(params[:id])
end

def gallery_params
  params.require(:gallery).permit(:bike_id, :image)
end
end
