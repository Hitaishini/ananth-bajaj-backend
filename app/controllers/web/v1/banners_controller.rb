class Web::V1::BannersController < ApplicationController
  before_action :set_banner, only: [:show, :update, :destroy]

  # GET /web/v1/banners
  # GET /web/v1/banners.json
  def index
    @banners = Banner.all.order("updated_at DESC").order("created_at DESC").order(:display_order)

    render json: @banners
  end

  # GET /web/v1/banners/1
  # GET /web/v1/banners/1.json
  def show
    render json: @banner
  end

  # POST /web/v1/banners
  # POST /web/v1/banners.json
  def create
    @banner = Banner.new(banner_params)

    if @banner.save
      audit(@banner, current_user)
     if set_host == "localhost:3000"
        @banner.update(image_host_url: "http://" + set_host + @banner.image.url) if @banner.image.url
      else
        @banner.update(image_host_url: "https://" + set_host + @banner.image.url) if @banner.image.url
      end
      render json: @banner, status: :created
    else
      render json: @banner.errors, status: :unprocessable_entity
    end
   
  end

  # PATCH/PUT /web/v1/banners/1
  # PATCH/PUT /web/v1/banners/1.json
  def update
    @banner = Banner.find(params[:id])

    if @banner.update(banner_params)
      audit(@banner, current_user)
      render json: @banner
      #head :no_content
    else
      render json: @banner.errors, status: :unprocessable_entity
    end
  end

  def update_image
    @banner = Banner.find(params[:banner][:id])
    @banner.remove_image! if @banner.image
    if @banner.update(banner_params)
      @banner.image = params[:banner][:image]
      @banner.save
      if set_host == "localhost:3000"
        @banner.update(image_host_url: "http://" + set_host + @banner.image.url) if @banner.image.url
      else
        @banner.update(image_host_url: "https://" + set_host + @banner.image.url) if @banner.image.url
      end
      render json: @banner
      #head :no_content
    else
      render json: @banner.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/banners/1
  # DELETE /web/v1/banners/1.json
  def destroy
    audit(@banner, current_user)
    @banner.destroy
    

    head :no_content
  end

  def delete_banners
    @banners = params[:banner_ids]
    @banners.each do |banner|
      Banner.find(banner).delete
    end
  end

  private

  def set_banner
    @banner = Banner.find(params[:id])
  end

  def banner_params
    params.require(:banner).permit(:image, :active, :image_host_url,:bike_id, :display_order,:button_text,:button_link_url,:button_color)
  end
end
    