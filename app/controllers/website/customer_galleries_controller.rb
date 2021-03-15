class Website::CustomerGalleriesController < ApplicationController
  before_action :set_customer_gallery, only: [:show]

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

  private

    def set_customer_gallery
      @customer_gallery = CustomerGallery.find(params[:id])
    end

end
