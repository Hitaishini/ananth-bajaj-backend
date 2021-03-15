class Website::ContactNumbersController < ApplicationController
  before_action :set_contact_number, only: [:show]
  skip_before_filter :authenticate_user!

  # GET /web/v1/contact_numbers
  # GET /web/v1/contact_numbers.json
  def index
    @contact_numbers = ContactNumber.all

    render json: @contact_numbers
  end

  # GET /web/v1/contact_numbers/1
  # GET /web/v1/contact_numbers/1.json
  def show
    render json: @contact_number
  end

  def get_contact_numbers
    contact_numbers = ContactNumber.all
    @numbers = []
    contact_numbers.each do |number|
      if number.contact_type.present? 
        if number.contact_type.label.include?params[:category]
           @numbers << number
        end
      else
        number
      end
    end
    #.where(category: params[:category])
     render json: @numbers #each_serializer: Mobile::V1::ContactNumbersSerializer
  end

  def get_booking_number
    @contact_numbers = ContactNumber.where(category: params[:category])
    render json: @contact_numbers
  end

  # POST /web/v1/contact_numbers
  # POST /web/v1/contact_numbers.json

  private

    def set_contact_number
      @contact_number = ContactNumber.find(params[:id])
    end

end
