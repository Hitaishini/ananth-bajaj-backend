class Website::AccessoriesController < ApplicationController
  before_action :set_accessory, only: [:show, :update, :destroy]
  skip_before_filter :authenticate_user! #:except => [:get_accessories_enquiries, :delete_accessories, :bike_with_accessories]
  # GET /web/v1/accessories
  # GET /web/v1/accessories.json
  def index
    limit, offset = Calculator.limit_and_offset(params)
    accs = Accessory.all
    
    render json: accs
  end

  #bike with accessories
   def bike_with_accessories
    @bike = Bike.where(id: Accessory.pluck(:bike_id))
     render json: @bike, root: "bikes", each_serializer: Website::V1::BikeSerializer
  end

  #accesories with perticular bike
  def accessories_bike
    @bike = Bike.find_by_id(params[:bike_id])
    @accessories = @bike.accessories if @bike

     render json: @accessories
  end

  # GET /web/v1/accessories/1
  # GET /web/v1/accessories/1.json
  def show
    render json: @accessory
  end

  # POST /web/v1/accessories
  # POST /web/v1/accessories.json
  def create
    @accessory = Accessory.new(accessory_params)

    if @accessory.save
      render json: @accessory, status: :created
    else
      render json: @accessory.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/accessories/1
  # PATCH/PUT /web/v1/accessories/1.json
  def update
    @accessory = Accessory.find(params[:id])

    if @accessory.update(accessory_params)
      audit(@accessory, current_user)
      head :no_content
    else
      render json: @accessory.errors, status: :unprocessable_entity
    end
  end

  def update_accessory_image
    @accessory = Accessory.find(params[:id])
    @accessory.remove_image! if @accessory.image
    if @accessory.update(accessory_params)
      @accessory.image = params[:accessory][:image]
      @accessory.save
      render json: @accessory
      #head :no_content
    else
      render json: @accessory.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/accessories/1
  # DELETE /web/v1/accessories/1.json
  def destroy
    audit(@accessory, current_user)
    @accessory.destroy
    

    head :no_content
  end

  def get_accessories_enquiries
    @accessory_enquiries = AccessoryEnquiry.all
    render json: @accessory_enquiries
  end

  def delete_accessories
    @accessories = params[:accessories_ids]
   @accessories.each do |accessories|
    Accessory.find(accessories).delete
  end
end

private

def set_accessory
  @accessory = Accessory.find(params[:id])
end

def accessory_params
  params.require(:accessory).permit(:title, :description, :tag, :image, :accessory_category_id, :part_number, :size, :price, :bike_id)
end
end
