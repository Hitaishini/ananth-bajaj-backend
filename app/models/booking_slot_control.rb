class BookingSlotControl < ApplicationRecord


	def self.slot_count(params)
		booking_slot = BookingSlot.where('category = ? AND dealer_location = ?', params[:category], params[:dealer_location]).first
		booking_slot_control = BookingSlotControl.where('category = ? AND dealer_location = ? AND booking_date = ?', params[:category], params[:dealer_location], params[:date].to_date).first
		booking_slot_count = booking_slot_control ? (TestRide.where('location = ? AND ride_date = ?', booking_slot_control.dealer_location, booking_slot_control.booking_date) + ServiceBooking.where('service_station = ? AND service_date = ?', booking_slot_control.dealer_location, booking_slot_control.booking_date)).count : 0
		if booking_slot 
			if params[:update] == true
				if booking_slot_control 
					return { message: "go with the booking", status: true }
				else
					BookingSlotControl.update_slot_count_value(booking_slot, params, booking_slot_count)
				end
			else
				if booking_slot_control 
					BookingSlotControl.slot_count_value(booking_slot, booking_slot_control, booking_slot_count)
				else
					slot_control = BookingSlotControl.create(dealer_location: booking_slot.dealer_location, category: booking_slot.category, available_slots: booking_slot.total_slots, booking_date: params[:date].to_date)
					BookingSlotControl.slot_count_value(booking_slot, slot_control, booking_slot_count)
				end
			end
		else
			return {message: "Booking slot is not available on the selected date or location. Kindly change location or date.", status: false }
		end
	end

	def self.update_slot_count_value(booking_slot, params, count)
		if params[:test_booking_id]
			booking = TestRide.find_by_id(params[:test_booking_id])
			booking_value = BookingSlotControl.where('dealer_location = ? AND booking_date = ?', booking.location, booking.ride_date).first if booking
			slots_old = booking_value.available_slots + 1
			booking_value.update(available_slots: slots_old) if booking_value
		else
			booking = ServiceBooking.find_by_id(params[:service_booking_id])
			booking_value = BookingSlotControl.where('dealer_location = ? AND booking_date = ?', booking.service_station, booking.service_date).first if booking
			slots_old = booking_value.available_slots + 1
			booking_value.update(available_slots: slots_old) if booking_value
		end
		slot_control = BookingSlotControl.create(dealer_location: booking_slot.dealer_location, category: booking_slot.category, available_slots: booking_slot.total_slots, booking_date: params[:date].to_date)
		BookingSlotControl.slot_count_value(booking_slot, slot_control, count)
	end

	def self.slot_count_value(booking_slot, booking_slot_count, count)
		total_slots = count + booking_slot_count.available_slots
		updated_slots = booking_slot.total_slots - total_slots
		
		if updated_slots == 0 && booking_slot_count.available_slots > 0
			slots = booking_slot_count.available_slots - 1
			booking_slot_count.update(available_slots: slots)
			return { message: "go with the booking", status: true }
		elsif updated_slots > 0
			slot_count = updated_slots + booking_slot_count.available_slots - 1
            booking_slot_count.update(available_slots: slot_count)
			return { message: "go with the booking", status: true }
		elsif updated_slots < 0
		    slot_count = booking_slot_count.available_slots + updated_slots
		    if slot_count > 0
		    	booking_slot_count.update(available_slots: slot_count - 1)
			    return { message: "go with the booking", status: true }
		    else
               return { message: "there is no bookings for this location", status: true }
		    end
		else	
			return { message: "There is no test ride slot available at this location on this day. Kindly try another location or day for your test ride booking", status: false }
		end
	end

	
end
