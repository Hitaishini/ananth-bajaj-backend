class Web::V1::BookingSlotsController < ApplicationController
  before_action :set_booking_slot, only: [:show, :update, :destroy]
  skip_before_filter :authenticate_user!

  # GET /web/v1/booking_slots
  # GET /web/v1/booking_slots.json
  def index
    @booking_slots = BookingSlot.all

    render json: @booking_slots
  end

  # GET /web/v1/booking_slots/1
  # GET /web/v1/booking_slots/1.json
  def show
    render json: @booking_slot
  end

  # POST /web/v1/booking_slots
  # POST /web/v1/booking_slots.json
  def create
    @booking_slot = BookingSlot.new(booking_slot_params)

    if @booking_slot.save
      render json: @booking_slot, status: :created
    else
      render json: @booking_slot.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/booking_slots/1
  # PATCH/PUT /web/v1/booking_slots/1.json
  def update
    @booking_slot = BookingSlot.find(params[:id])

    if @booking_slot.update(booking_slot_params)
      head :no_content
    else
      render json: @booking_slot.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/booking_slots/1
  # DELETE /web/v1/booking_slots/1.json
  def destroy
    @booking_slot.destroy

    head :no_content
  end

  def delete_booking_slots
    @slots = params[:booking_slot_ids]
    @slots.each do |slot|
      BookingSlot.find(slot).delete
    end
  end

  def slot_counts
    @slot = BookingSlotControl.all
    
    render json: @slot
  end

  private

    def set_booking_slot
      @booking_slot = BookingSlot.find(params[:id])
    end

    def booking_slot_params
      params.require(:booking_slot).permit(:dealer_location, :category, :total_slots)
    end
end
