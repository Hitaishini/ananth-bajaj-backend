class Web::V1::DashboardsController < ApplicationController
	# before_filter :authenticate_user!
	respond_to :json

  def bookings_by_period
  	if params[:category] == 'test_rides'
    	bookings = TestRide.where("ride_date > ? AND ride_date < ?", params[:start_date].to_date, params[:end_date].to_date).order("ride_date DESC").order("ride_date DESC")
   	elsif params[:category] == 'service_bookings'
   		bookings = ServiceBooking.where("service_date > ? AND service_date < ?", params[:start_date].to_date, params[:end_date].to_date).order("service_date DESC").order("service_date DESC")
   	elsif params[:category] == 'insurances' 
      bookings = InsuranceRenewal.where("purchase_date > ? AND purchase_date < ?", params[:start_date].to_date, params[:end_date].to_date).order("purchase_date DESC").order("purchase_date DESC")
   	elsif params[:category] == 'contacts'
      bookings = Enquiry.where("created_at > ? AND created_at < ?", params[:start_date].to_date, params[:end_date].to_date).order("created_at DESC").order("created_at DESC")
    elsif params[:category] == 'feedbacks'
      bookings = Feedback.where("created_at > ? AND created_at < ?", params[:start_date].to_date, params[:end_date].to_date).order("created_at DESC").order("created_at DESC")
    end	
    render json: bookings, root: 'bookings'
  end 
end