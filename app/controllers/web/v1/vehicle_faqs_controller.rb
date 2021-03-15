class Web::V1::VehicleFaqsController < ApplicationController
  before_action :set_vehicle_faq, only: [:show, :update, :destroy]
  skip_before_filter :authenticate_user! 

  def index
   @vehicle_faqs = VehicleFaq.all.order('id DESC')

   render json: @vehicle_faqs, status: 200, each_serializer: Web::V1::VehicleFaqSerializer

  end

  def create
  	@vehicle_faq = VehicleFaq.new(vehicle_faq_params)
  	if @vehicle_faq.save
  			render json: @vehicle_faq, status: 200, serializer: Web::V1::VehicleFaqSerializer
  	else
        render json: @accessory.errors, status: :unprocessable_entity
  	end

  end


  def update
    if @vehicle_faq.update(vehicle_faq_params)
        render json: @vehicle_faq, status: 200, serializer: Web::V1::VehicleFaqSerializer
      else
        render json: @accessory.errors, status: :unprocessable_entity
    end
  end

  def show 
    if @vehicle_faq.present?
        render json: @vehicle_faq, status: 200, serializer: Web::V1::VehicleFaqSerializer
      else
        render json: @accessory.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @vehicle_faq.destroy
        head :no_content
      else
        render json: @accessory.errors, status: :unprocessable_entity
    end
  end

  def destroy_all_vehicle_faqs
    if VehicleFaq.destroy(params[:faq_ids])
      head :no_content
    else
       render json: @accessory.errors, status: :unprocessable_entity
    end
  end


private

def set_vehicle_faq
  @vehicle_faq = VehicleFaq.find(params[:id])
end

def vehicle_faq_params
  params.require(:vehicle_faq).permit(:bike_type, :cate_gory_type, :specification, :value, :bike_id)
end

end