class Website::AccessoryCategoriesController < ApplicationController
  before_action :set_accessory_category, only: [:show]
  skip_before_filter :authenticate_user!, :except => [:accessories_enquiry]


  # GET /web/v1/accessory_categories
  # GET /web/v1/accessory_categories.json
  def index
    @accessory_categories = AccessoryCategory.all

    render json: @accessory_categories
  end

  # GET /web/v1/accessory_categories/1
  # GET /web/v1/accessory_categories/1.json
  def show
    render json: @accessory_category
  end

  def get_tags
    @accessory_categories = AccessoryCategory.find_by_id params[:id]
    @tags = @accessory_categories.try(:tags)
    render json: @tags
  end

  def accessories_enquiry
    @accessory_enquiry = AccessoryEnquiry.create(user_id: current_user.id, accessory_id: params[:accessory_ids])
    @accessory_enquiry.send_notification(current_user)
    render json: @accessory_enquiry
  end

  # POST /web/v1/accessory_categories
 

  private

    def set_accessory_category
      @accessory_category = AccessoryCategory.find(params[:id])
    end

end
