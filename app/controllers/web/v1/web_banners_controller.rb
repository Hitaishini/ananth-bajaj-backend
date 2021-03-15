class Web::V1::WebBannersController < ApplicationController
  before_action :set_web_banner, only: [:show, :update, :destroy]

  # GET /web/v1/web_banners
  # GET /web/v1/web_banners.json
  def index
    @web_banners = WebBanner.all

    render json: @web_banners
  end

  # GET /web/v1/web_banners/1
  # GET /web/v1/web_banners/1.json
  def show
    render json: @web_banner
  end

  # POST /web/v1/web_banners
  # POST /web/v1/web_banners.json
  def create
    @web_banner = WebBanner.new(web_banner_params)

    if @web_banner.save
      audit(@web_banner, current_user)
      render json: @web_banner, status: :created
    else
      render json: @web_banner.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/web_banners/1
  # PATCH/PUT /web/v1/web_banners/1.json
  def update
    @web_banner = WebBanner.find(params[:id])

    if @web_banner.update(web_banner_params)
      audit(@web_banner, current_user)
      head :no_content
    else
      render json: @web_banner.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/web_banners/1
  # DELETE /web/v1/web_banners/1.json
  def destroy
    audit(@web_banner, current_user)
    @web_banner.destroy

    head :no_content
  end

  def delete_web_banners
     @web_banners = params[:web_banner_ids]
    @web_banners.each do |acc|
      WebBanner.find(acc).destroy
    end
    head :no_content 
  end

  private

    def set_web_banner
      @web_banner = WebBanner.find(params[:id])
    end

    def web_banner_params
      params.require(:web_banner).permit(:image, :s3_image_url,:active,:bike_id,:display_order,:button_text,:button_link_url,:button_color,:button_visible)
    end
end
