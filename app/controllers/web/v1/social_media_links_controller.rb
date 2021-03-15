class Web::V1::SocialMediaLinksController < ApplicationController
  before_action :set_social_media_link, only: [:show, :update, :destroy]

  # GET /web/v1/social_media_links
  # GET /web/v1/social_media_links.json
  def index
    @social_media_links = SocialMediaLink.all

    render json: @social_media_links
  end

  # GET /web/v1/social_media_links/1
  # GET /web/v1/social_media_links/1.json
  def show
    render json: @social_media_link
  end

  # POST /web/v1/social_media_links
  # POST /web/v1/social_media_links.json
  def create
    @social_media_link = SocialMediaLink.new(social_media_link_params)

    if @social_media_link.save
      render json: @social_media_link, status: :created
    else
      render json: @social_media_link.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/social_media_links/1
  # PATCH/PUT /web/v1/social_media_links/1.json
  def update
    @social_media_link = SocialMediaLink.find(params[:id])

    if @social_media_link.update(social_media_link_params)
      head :no_content
    else
      render json: @social_media_link.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/social_media_links/1
  # DELETE /web/v1/social_media_links/1.json
  def destroy
    @social_media_link.destroy

    head :no_content
  end

   def delete_social_links
    @banners = params[:social_link_ids]
    @banners.each do |banner|
      SocialMediaLink.find(banner).destroy
    end
  end

  private

    def set_social_media_link
      @social_media_link = SocialMediaLink.find(params[:id])
    end

    def social_media_link_params
      params.require(:social_media_link).permit(:social_media_name, :social_media_url, :display_order, :visible)
    end
end
