class Website::BookingTimeControlsController < ApplicationController
	skip_before_filter :authenticate_user!
  
  def find_book_time_controls
    @book_time_control = BookingTimeControl.where('category = ? AND weekday = ?', params[:category], params[:weekday])
    render json: @book_time_control
  end

    #for finding booking time control
  def book_time_control
     @control = BookingTimeControl.book_time_control_method(params)
     
     render json: @control 
  end

end
