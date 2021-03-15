class Website::SocialMediaLinksController < ApplicationController
  before_action :set_website_social_media_link, only: [:show, :update, :destroy]

  # GET /website/social_media_links
  # GET /website/social_media_links.json
  def index
    @website_social_media_links = Website::SocialMediaLink.all

    render json: @website_social_media_links
  end

  # GET /website/social_media_links/1
  # GET /website/social_media_links/1.json
  def show
    render json: @website_social_media_link
  end

  # POST /website/social_media_links
  # POST /website/social_media_links.json
  def create
    @website_social_media_link = Website::SocialMediaLink.new(website_social_media_link_params)

    if @website_social_media_link.save
      render json: @website_social_media_link, status: :created, location: @website_social_media_link
    else
      render json: @website_social_media_link.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /website/social_media_links/1
  # PATCH/PUT /website/social_media_links/1.json
  def update
    @website_social_media_link = Website::SocialMediaLink.find(params[:id])

    if @website_social_media_link.update(website_social_media_link_params)
      head :no_content
    else
      render json: @website_social_media_link.errors, status: :unprocessable_entity
    end
  end

  # DELETE /website/social_media_links/1
  # DELETE /website/social_media_links/1.json
  def destroy
    @website_social_media_link.destroy

    head :no_content
  end

  private

    def set_website_social_media_link
      @website_social_media_link = Website::SocialMediaLink.find(params[:id])
    end

    def website_social_media_link_params
      params[:website_social_media_link]
    end
end
