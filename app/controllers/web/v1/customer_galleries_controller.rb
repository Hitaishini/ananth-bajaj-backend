class Web::V1::CustomerGalleriesController < ApplicationController
  before_action :set_customer_gallery, only: [:show, :update, :destroy]

  # GET /website/customer_galleries
  # GET /website/customer_galleries.json
  def index
    @customer_galleries = CustomerGallery.all

    render json: @customer_galleries
  end

  # GET /website/customer_galleries/1
  # GET /website/customer_galleries/1.json
  def show
    render json: @customer_gallery
  end

  # POST /website/customer_galleries
  # POST /website/customer_galleries.json
  def create
    @customer_gallery = CustomerGallery.new(customer_gallery_params)

    if @customer_gallery.save
      audit(@customer_gallery, current_user)
      render json: @customer_gallery, status: :created
    else
      render json: @customer_gallery.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /website/customer_galleries/1
  # PATCH/PUT /website/customer_galleries/1.json
  def update
    @customer_gallery = CustomerGallery.find(params[:id])

    if @customer_gallery.update(customer_gallery_params)
       audit(@customer_gallery, current_user)
      head :no_content
    else
      render json: @customer_gallery.errors, status: :unprocessable_entity
    end
  end

  # DELETE /website/customer_galleries/1
  # DELETE /website/customer_galleries/1.json
  def destroy
    audit(@customer_gallery, current_user)
    @customer_gallery.destroy

    head :no_content
  end

  #for multiplae delete
  def delete_customer_galleries
    @galleries = params[:gallery_ids]
    @galleries.each do |gal|
      ContactType.find(gal).delete
    end
  end

  private

    def set_customer_gallery
      @customer_gallery = CustomerGallery.find(params[:id])
    end

    def customer_gallery_params
      params.require(:customer_gallery).permit(:video_url, :image, :powered_by)
    end
end
