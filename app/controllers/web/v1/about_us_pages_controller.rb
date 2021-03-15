class Web::V1::AboutUsPagesController < ApplicationController
  before_action :set_about_us_page, only: [:show, :update, :destroy]

  # GET /web/v1/about_us_pages
  # GET /web/v1/about_us_pages.json
  def index
    @about_us_pages = AboutUsPage.all.order("updated_at DESC")

    render json: @about_us_pages
  end

  # GET /web/v1/about_us_pages/1
  # GET /web/v1/about_us_pages/1.json
  def show
    render json: @about_us_page
  end

  # POST /web/v1/about_us_pages
  # POST /web/v1/about_us_pages.json
  def create
    @about_us_page = AboutUsPage.new(about_us_page_params)

    if @about_us_page.save
      render json: @about_us_page, status: :created
    else
      render json: @about_us_page.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/about_us_pages/1
  # PATCH/PUT /web/v1/about_us_pages/1.json
  def update
    @about_us_page = AboutUsPage.find(params[:id])

    if @about_us_page.update(about_us_page_params)
      head :no_content
    else
      render json: @about_us_page.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/about_us_pages/1
  # DELETE /web/v1/about_us_pages/1.json
  def destroy
    @about_us_page.destroy

    head :no_content
  end

  def delete_about_details
    @about_pages = params[:page_ids]
    @about_pages.each do |page|
      AboutUsPage.find(page).delete
    end
  end

  private

    def set_about_us_page
      @about_us_page = AboutUsPage.find(params[:id])
    end

    def about_us_page_params
      params.require(:about_us_page).permit(:image, :category)
    end
end
