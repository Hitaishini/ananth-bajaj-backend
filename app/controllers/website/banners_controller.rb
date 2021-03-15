class Website::BannersController < ApplicationController
  skip_before_filter :authenticate_user!
  before_action :set_banner, only: [:show, :update, :destroy]

  # GET /web/v1/banners
  # GET /web/v1/banners.json
  def index
    @banners = Banner.where('active =?', true).order(:display_order)

    render json: @banners
  end

  # GET /web/v1/banners/1
  # GET /web/v1/banners/1.json
  def show
    render json: @banner
  end



  private

    def set_banner
      @banner = Banner.find(params[:id])
    end
    
end
