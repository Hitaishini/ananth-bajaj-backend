class BookingTimeControl < ApplicationRecord

def self.book_time_control_method(params)
    #for Category and Day
    date = params[:date].to_datetime
    week_day = params[:date].to_datetime.strftime("%A").downcase.capitalize
    #for time
    #days = Time.days_in_month(m, y)
    time = DateTime.parse(params[:time]).strftime("%H:%M")
    #current_day = params[:current_date].to_datetime
    current_day = Date.today.to_datetime
    #for days prior
    date_minus = (date - current_day).to_i #Date.today + 
    #for days prior
    #date_minus = (date.day + date.month * date.year) - (current_day.day + current_day.month * current_day.year)
    @book_time_control = BookingTimeControl.where('category = ? AND weekday = ?', params[:category], week_day).first

    if @book_time_control
    	if date_minus >= @book_time_control.days_prior
            if params[:count] == 0
                 if time >= @book_time_control.open_time.strftime("%H:%M") && time <= @book_time_control.end_time.strftime("%H:%M")
                   return true 
                    #return { message: "go with the booking", status: true }
                     #BookingSlotControl.slot_count(params)
                 else
                    return { message: "Selected time slot not available.Please make a booking between #{@book_time_control.open_time.strftime("%I:%M%p")} to #{@book_time_control.end_time.strftime("%I:%M%p")}", status: false }
                 end
            else
             return { message: "Selected booking slot not available. Please make a booking On or After #{week_day}, #{params[:date]} between #{@book_time_control.open_time.strftime("%I:%M%p")} to #{@book_time_control.end_time.strftime("%I:%M%p")}", status: false }
            end
        else
          date_asd = params[:date].to_datetime + 1.day
          params[:date] = date_asd.strftime("%d-%m-%Y")
          params[:count] += 1
          BookingTimeControl.book_time_control_method(params)
        end
    else
        return {message: "there is no record on this day for this category. please change your date", status: false }
    end

end


end
