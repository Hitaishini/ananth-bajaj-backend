 class Website::ServiceBookingsController < ApplicationController
  before_action :set_service_booking, only: [:show, :update, :destroy]
  skip_before_filter :authenticate_user!

  # GET /web/v1/service_bookings
  # GET /web/v1/service_bookings.json
  def index
    @service_bookings = ServiceBooking.all

    render json: @service_bookings
  end

  # GET /web/v1/service_bookings/1
  # GET /web/v1/service_bookings/1.json
  def show
    render json: @service_booking
  end

  # POST /web/v1/service_bookings
  # POST /web/v1/service_bookings.json
  def create
    @service_booking = ServiceBooking.new(service_booking_params)
    @control = BookingTimeControl.book_time_control_method(params)
    
    if @control == true
      if @service_booking.save
        render json: @service_booking, status: :created, serializer: Website::V1::ServiceBookingSerializer
        # Notification
        @service_booking.sevice_booking_notification(I18n.t('Notification.service_booking'), I18n.t('Email.service_booking_dealer'), I18n.t('Email.service_booking_user'), params)
      else
        render json: @service_booking.errors, status: :unprocessable_entity
      end
    else
      render json: @control
    end 
  end

  # PATCH/PUT /web/v1/service_bookings/1
  # PATCH/PUT /web/v1/service_bookings/1.json
  def update
    @service_booking = ServiceBooking.find(params[:id])
    @control = BookingTimeControl.book_time_control_method(params)
    
    if @control == true
      if @service_booking.update(service_booking_params)
        render json: @service_booking, status: :ok, serializer: Website::V1::ServiceBookingSerializer
        @service_booking.delay.sevice_booking_notification(I18n.t('Notification.service_booking_updated'), I18n.t('Email.service_booking_updated_dealer'), I18n.t('Email.service_booking_updated_user'), params)
      else
        render json: @service_booking.errors, status: :unprocessable_entity
      end
    else
      render json: @control
    end 
  end

  # DELETE /web/v1/service_bookings/1
  # DELETE /web/v1/service_bookings/1.json
  def destroy
    @service_booking.update_attribute(:status, 'Cancelled')
      #booking_slot_control = BookingSlotControl.where('category = ? AND dealer_location = ? AND booking_date = ?', "Book Service", @service_booking.service_station, @service_booking.service_date).first
      #booking_slot_control.update(available_slots: booking_slot_control.available_slots + 1) if booking_slot_control
    head :no_content
    @service_booking.sevice_booking_notification(I18n.t('Notification.service_booking_destroyed'), I18n.t('Email.service_booking_delete_dealer'), I18n.t('Email.service_booking_delete_user'), params)
  end

  def my_bookings
    @old_bookings = (ServiceBooking.where('(user_id = ? AND service_date < ?) OR (user_id = ? AND status = ?)', params[:user_id], Date.today, params[:user_id], 'Cancelled').order(:updated_at).reverse_order + TestRide.where('(user_id = ? AND ride_date < ?) OR (user_id = ? AND status = ?)', params[:user_id], Date.today,params[:user_id], 'Cancelled').order(:updated_at).reverse_order)
    @new_bookings = (ServiceBooking.where('user_id = ? AND service_date >= ? AND status = ?', params[:user_id], Date.today, 'Active').order(:updated_at).reverse_order + TestRide.where('user_id = ? AND ride_date >= ? AND status = ?', params[:user_id], Date.today, 'Active').order(:updated_at).reverse_order)
    @bookings_all = Hash.new
    @bookings_all = {:old_bookings => @old_bookings, :new_bookings =>  @new_bookings}
    render json: @bookings_all
  end

  def delete_service_bookings
    @service_bookings = params[:service_booking_ids]
    @service_bookings.each do |service_booking|
      ServiceBooking.find(service_booking).delete
    end
  end

  private

  def set_service_booking
    @service_booking = ServiceBooking.find(params[:id])
  end

  def service_booking_params
    params.require(:service_booking).permit(:address, :service_type, :name, :email, :mobile, :user_id, :my_bike_id, :registration_number, :kms, :service_date, :service_time, :service_station, :comments, :request_pick_up, :service_status)
  end
end
