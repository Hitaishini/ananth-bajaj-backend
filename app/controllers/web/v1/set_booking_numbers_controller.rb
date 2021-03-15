class Web::V1::SetBookingNumbersController < ApplicationController
  before_action :set_set_booking_number, only: [:show, :update, :destroy]

  # GET /web/v1/set_booking_numbers
  # GET /web/v1/set_booking_numbers.json
  def index
    @set_booking_numbers = SetBookingNumber.all.order("updated_at DESC").order("created_at DESC")

    render json: @set_booking_numbers
  end

  # GET /web/v1/set_booking_numbers/1
  # GET /web/v1/set_booking_numbers/1.json
  def show
    render json: @set_booking_number
  end

  # POST /web/v1/set_booking_numbers
  # POST /web/v1/set_booking_numbers.json
  def create
    @set_booking_number = SetBookingNumber.new(set_booking_number_params)

    if @set_booking_number.save
      render json: @set_booking_number, status: :created
    else
      render json: @set_booking_number.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/set_booking_numbers/1
  # PATCH/PUT /web/v1/set_booking_numbers/1.json
  def update
    @set_booking_number = SetBookingNumber.find(params[:id])

    if @set_booking_number.update(set_booking_number_params)
      head :no_content
    else
      render json: @set_booking_number.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/set_booking_numbers/1
  # DELETE /web/v1/set_booking_numbers/1.json
  def destroy
    @set_booking_number.destroy

    head :no_content
  end

  private

    def set_set_booking_number
      @set_booking_number = SetBookingNumber.find(params[:id])
    end

    def set_booking_number_params
      params.require(:set_booking_number).permit(:booking_number, :category, :label, :active)
    end
end
