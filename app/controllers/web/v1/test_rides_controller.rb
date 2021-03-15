class Web::V1::TestRidesController < ApplicationController
  before_action :set_test_ride, only: [:show, :update, :destroy]

  # GET /web/v1/test_rides
  # GET /web/v1/test_rides.json
  def index
    limit, offset = Calculator.limit_and_offset(params)
    @test_rides = TestRide.all.limit(limit).offset(offset).order("updated_at DESC").order("created_at DESC")

    render json: @test_rides, each_serializer: Web::V1::TestRideSerializer
  end

  # GET /web/v1/test_rides/1
  # GET /web/v1/test_rides/1.json
  def show
    render json: @test_ride, serializer: Web::V1::TestRideSerializer
  end

  # POST /web/v1/test_rides
  # POST /web/v1/test_rides.json
  def create
    
    @test_ride = TestRide.new(test_ride_params)
    if @test_ride.save
       audit(@test_ride, current_user)
      render json: @test_ride, status: 200
      @test_ride.delay.test_ride_booking_notification(I18n.t('Notification.test_ride_booking'), I18n.t('Email.test_ride_booking_dealer'), I18n.t('Email.test_ride_booking_user'), params)
    else
      render json: @test_ride.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/test_rides/1
  # PATCH/PUT /web/v1/test_rides/1.json
  def update
    
    @test_ride = TestRide.find(params[:id])
    if @test_ride.update(test_ride_params)
       audit(@test_ride, current_user)
      render json: @test_ride, status: :ok, serializer: Web::V1::TestRideSerializer
      @test_ride.delay.test_ride_booking_notification(I18n.t('Notification.test_ride_updated'), I18n.t('Email.test_ride_booking_update_dealer'), I18n.t('Email.test_ride_booking_update_user'), params)
    else
      render json: @test_ride.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/test_rides/1
  # DELETE /web/v1/test_rides/1.json
  def destroy
    audit(@test_ride, current_user)
    @test_ride.destroy
     
    head :no_content
    #@test_ride.test_ride_booking_notification(I18n.t('Notification.test_ride_destroyed'), I18n.t('Email.test_ride_booking_delete_dealer'), I18n.t('Email.test_ride_booking_delete_user'))
  end

  def all_bookings
   if params[:month] && params[:year]
    service_bookings = ServiceBooking.where('extract(year  from service_date) = ?', params[:year]).where('extract(month  from service_date) = ?', params[:month])
    test_ride_bookings = TestRide.where('extract(year  from ride_date) = ?', params[:year]).where('extract(month  from ride_date) = ?', params[:month])
    insurance_bookings = InsuranceRenewal.where('extract(year  from purchase_date) = ?', params[:year]).where('extract(month  from purchase_date) = ?', params[:month])
  else
    service_bookings = ServiceBooking.where("service_date > ? AND service_date < ?", params[:start_date].to_date, params[:end_date].to_date)
    test_ride_bookings = TestRide.where("ride_date > ? AND ride_date < ?", params[:start_date].to_date, params[:end_date].to_date)
    insurance_bookings = InsuranceRenewal.where("purchase_date > ? AND purchase_date < ?", params[:start_date].to_date, params[:end_date].to_date)
  end
  service = service_bookings.collect { |service_booking| date = service_booking.service_date.strftime("%d/%m/%Y") 
    Hash[date, service_booking] }
    test_ride = test_ride_bookings.collect { |test_ride| date = test_ride.ride_date.strftime("%d/%m/%Y")
      Hash[date, test_ride] }
      insurance_renewal = insurance_bookings.collect { |insurance_booking| date = insurance_booking.purchase_date.strftime("%d/%m/%Y") 
        Hash[date, insurance_booking] }
        all_bookings_array = service + test_ride + insurance_renewal
        bookings = all_bookings_array.flat_map(&:entries).group_by(&:first)
        @all_bookings = bookings.map{|k,v| Hash[date: k, count: v.map(&:last).count, all_bookings: v.map(&:last).collect{ |bookings| 
          if bookings.try(:service_date) 
            { service_bookings: bookings }
          elsif bookings.try(:ride_date)
            { test_ride_bookings: bookings }
          elsif bookings.try(:purchase_date)
            { insurence_renewal_bookings: bookings }
          else
            {contact: bookings }
          end
          }.flat_map(&:entries).group_by(&:first).map{ |k,v| Hash["#{k}_count": v.map(&:last).count, "#{k}": v.map(&:last)  ] }  ]  }
          render json: @all_bookings, :root => "bookings"
        end

def bookings_with_day
  service_bookings = ServiceBooking.where('extract(day  from service_date) = ? AND extract(month  from service_date) = ? AND extract(year  from service_date) = ?', params[:day], params[:month], params[:year])
  test_ride_bookings = TestRide.where('extract(day  from ride_date) = ? AND extract(month  from ride_date) = ? AND extract(year  from ride_date) = ?', params[:day], params[:month], params[:year])
  insurance_bookings = InsuranceRenewal.where('extract(day  from purchase_date) = ? AND extract(month  from purchase_date) = ? AND extract(year  from purchase_date) = ?', params[:day], params[:month], params[:year])

  @bookings = {service_bookings: service_bookings, test_drive_bookings: test_ride_bookings, insurence_renewal_bookings: insurance_bookings }
  render json: @bookings.to_json, :root => "bookings"
end

def delete_test_rides
  @test_rides = params[:test_ride_ids]
  @test_rides.each do |test_ride|
    TestRide.find(test_ride).delete
  end
end

def bookings_with_count
  if params[:month] && params[:year]
    service_bookings = ServiceBooking.where('extract(year  from service_date) = ?', params[:year]).where('extract(month  from service_date) = ?', params[:month])
    test_ride_bookings = TestRide.where('extract(year  from ride_date) = ?', params[:year]).where('extract(month  from ride_date) = ?', params[:month])
    insurance_bookings = InsuranceRenewal.where('extract(year  from purchase_date) = ?', params[:year]).where('extract(month  from purchase_date) = ?', params[:month])
    user = User.where('extract(year  from created_at) = ?', params[:year]).where('extract(month  from created_at) = ?', params[:month]).count
    @users = User.where(role: "guest").count
  else
    service_bookings = ServiceBooking.where("service_date > ? AND service_date < ?", params[:start_date].to_date, params[:end_date].to_date)
    test_ride_bookings = TestRide.where("ride_date > ? AND ride_date < ?", params[:start_date].to_date, params[:end_date].to_date)
    insurance_bookings = InsuranceRenewal.where("purchase_date > ? AND purchase_date < ?", params[:start_date].to_date, params[:end_date].to_date)
    user = User.where("created_at > ? AND created_at < ? AND role = ? ", params[:start_date].to_date, params[:end_date].to_date, "guest").count
    @users = User.where(role: "guest").count
  end
  service = service_bookings.collect { |service_booking| date = service_booking.service_date.strftime("%d/%m/%Y") 
    Hash[date, service_booking] }
    test_ride = test_ride_bookings.collect { |test_ride| date = test_ride.ride_date.strftime("%d/%m/%Y")
      Hash[date, test_ride] }
      insurance_renewal = insurance_bookings.collect { |insurance_booking| date = insurance_booking.purchase_date.strftime("%d/%m/%Y") 
        Hash[date, insurance_booking] }
        all_bookings_array = service + test_ride + insurance_renewal
        bookings = all_bookings_array.flat_map(&:entries).group_by(&:first)
        @all_bookings = bookings.map{|k,v| 
          @service = []
          @test_ride = []
          @insurence = []
  #@fgh = []
  Hash[date: k, count: v.map(&:last).count, all_bookings: v.map(&:last).collect{ |bookings| 
    if bookings.try(:service_date)
      @service << bookings
      { service_bookings: bookings }                 
    elsif bookings.try(:ride_date)
      @test_ride << bookings
      { test_ride_bookings: bookings }           
    elsif bookings.try(:purchase_date)
      @insurence << bookings
      { insurence_renewal_bookings: bookings }         
    else
      {contact: bookings }               
    end
    }.flat_map(&:entries).group_by(&:first).map{ |k,v| 
      Hash[service_booking_count: @service.count, test_ride_bookingcount: @test_ride.count, insurence_booking_count: @insurence.count]}.uniq 
    ] 

  }
  @count = {all_booking: @all_bookings, users_count: user, default_users_count: @users }
  render json: @count, :root => "bookings_users"
end

private

def set_test_ride
  @test_ride = TestRide.find(params[:id])
end

def test_ride_params
  params.require(:test_ride).permit(:user_id, :address, :name, :mobile, :email, :request_pick_up, :test_ride_done, :test_ride_confirmed, :bike, :ride_date, :ride_time, :location)
end

end
