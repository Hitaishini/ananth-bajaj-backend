class Web::V1::NotificationCategoriesController < ApplicationController
  before_action :set_notification_category, only: [:show, :update, :destroy]

  # GET /web/v1/notification_categories
  # GET /web/v1/notification_categories.json
  def index
    @notification_categories = NotificationCategory.all.order("updated_at DESC").order("created_at DESC")

    render json: @notification_categories
  end

  # GET /web/v1/notification_categories/1
  # GET /web/v1/notification_categories/1.json
  def show
    render json: @notification_category
  end

  # POST /web/v1/notification_categories
  # POST /web/v1/notification_categories.json
  def create
    @notification_category = NotificationCategory.new(notification_category_params)

    if @notification_category.save
      render json: @notification_category, status: :created
    else
      render json: @notification_category.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/notification_categories/1
  # PATCH/PUT /web/v1/notification_categories/1.json
  def update
    @notification_category = NotificationCategory.find(params[:id])

    if @notification_category.update(notification_category_params)
      head :no_content
    else
      render json: @notification_category.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/notification_categories/1
  # DELETE /web/v1/notification_categories/1.json
  def destroy
    @notification_category.destroy

    head :no_content
  end

  def delete_notification_categories
   @notification_categories = params[:notification_categories_ids]
   @notification_categories.each do |notification_categories|
    NotificationCategory.find(notification_categories).delete
  end
end

private

def set_notification_category
  @notification_category = NotificationCategory.find(params[:id])
end

def notification_category_params
  params.require(:notification_category).permit(:name, :category)
end
end
