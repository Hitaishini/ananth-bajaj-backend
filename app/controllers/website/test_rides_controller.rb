class Website::TestRidesController < ApplicationController
  skip_before_filter :authenticate_user!
  before_action :set_test_ride, only: [:show, :update, :destroy]

  # GET /web/v1/test_rides/1
  # GET /web/v1/test_rides/1.json
  def show
    render json: @test_ride
  end

  # POST /web/v1/test_rides
  # POST /web/v1/test_rides.json
  def create
    @test_ride = TestRide.new(test_ride_params)
    @control = BookingTimeControl.book_time_control_method(params)
    
    if @control == true
      if @test_ride.save
        render json: @test_ride, status: :created
        # Create Notifications
        @test_ride.delay.test_ride_booking_notification(I18n.t('Notification.test_ride_booking'), I18n.t('Email.test_ride_booking_dealer'), I18n.t('Email.test_ride_booking_user'), params)
      else
        render json: @test_ride.errors, status: :unprocessable_entity
      end
    else
      render json: @control
    end
  end

  # PATCH/PUT /web/v1/test_rides/1
  # PATCH/PUT /web/v1/test_rides/1.json
  def update
    @test_ride = TestRide.find(params[:id])
    @control = BookingTimeControl.book_time_control_method(params)

    if @control == true
      if @test_ride.update(test_ride_params)
        render json: @test_ride, status: :ok

        # Send Notification & Email
        @test_ride.delay.test_ride_booking_notification(I18n.t('Notification.test_ride_updated'), I18n.t('Email.test_ride_booking_update_dealer'), I18n.t('Email.test_ride_booking_update_user'), params)
      else
        render json: @test_ride.errors, status: :unprocessable_entity
      end
    else
      render json: @control
    end
  end

  # DELETE /web/v1/test_rides/1
  # DELETE /web/v1/test_rides/1.json
  def destroy
    @test_ride.update_attribute(:status, 'Cancelled')
   # booking_slot_control = BookingSlotControl.where('category = ? AND dealer_location = ? AND booking_date = ?', "Book Test Ride", @test_ride.location, @test_ride.ride_date).first
    #booking_slot_control.update(available_slots: booking_slot_control.available_slots + 1) if booking_slot_control
    head :no_content
    @test_ride.delay.test_ride_booking_notification(I18n.t('Notification.test_ride_destroyed'), I18n.t('Email.test_ride_booking_delete_dealer'), I18n.t('Email.test_ride_booking_delete_user'), params)
  end

  private

  def set_test_ride
    @test_ride = TestRide.find(params[:id])
  end

  def test_ride_params
    params.require(:test_ride).permit(:user_id, :address, :name, :mobile, :email, :request_pick_up, :test_ride_done, :test_ride_confirmed, :bike, :ride_date, :ride_time, :location)
  end
end
