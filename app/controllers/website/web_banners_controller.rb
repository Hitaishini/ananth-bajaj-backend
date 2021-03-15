class Website::WebBannersController < ApplicationController
  before_action :set_web_banner, only: [:show]
  skip_before_filter :authenticate_user!

  # GET /web/v1/web_banners
  # GET /web/v1/web_banners.json
  def index
    @web_banners = WebBanner.all

    render json: @web_banners
  end

  # GET /web/v1/web_banners/1
  # GET /web/v1/web_banners/1.json
  def show
    @web_banner = WebBanner.find(params[:id])

    render json: @web_banner
  end

end
