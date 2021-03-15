class Web::V1::AccessoryCategoriesController < ApplicationController
  before_action :set_accessory_category, only: [:show, :update, :destroy]

  # GET /web/v1/accessory_categories
  # GET /web/v1/accessory_categories.json
  def index
    @accessory_categories = AccessoryCategory.all.order("updated_at DESC").order("created_at DESC")

    render json: @accessory_categories
  end

  # GET /web/v1/accessory_categories/1
  # GET /web/v1/accessory_categories/1.json
  def show
    render json: @accessory_category
  end

  # POST /web/v1/accessory_categories
  # POST /web/v1/accessory_categories.json
  def create
    @accessory_category = AccessoryCategory.new(accessory_category_params)

    if @accessory_category.save
      audit(@accessory_category, current_user)
      render json: @accessory_category, status: :created
    else
      render json: @accessory_category.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/accessory_categories/1
  # PATCH/PUT /web/v1/accessory_categories/1.json
  def update
    @accessory_category = AccessoryCategory.find(params[:id])

    if @accessory_category.update(accessory_category_params)
      audit(@accessory_category, current_user)
      head :no_content
    else
      render json: @accessory_category.errors, status: :unprocessable_entity
    end
  end

  def update_accessory_categery_image
    @accessory_category = AccessoryCategory.find(params[:id])
    @accessory_category.remove_image! if @accessory_category.image
    if @accessory_category.update(accessory_category_params)
     @accessory_category.image = params[:accessory_category][:image]
     @accessory_category.save
     render json: @accessory_category
      #head :no_content
    else
      render json: @accessory_category.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/accessory_categories/1
  # DELETE /web/v1/accessory_categories/1.json
  def destroy
    audit(@accessory_category, current_user)
    @accessory_category.destroy
   

    head :no_content
  end

  def delete_accessory_categories
   @accessory_categories = params[:accessory_categories_ids]
   @accessory_categories.each do |accessory_categories|
    AccessoryCategory.find(accessory_categories).delete
  end
end

private

def set_accessory_category
  @accessory_category = AccessoryCategory.find(params[:id])
end

def accessory_category_params
  params.require(:accessory_category).permit(:title, :description, :image)
end
end
