class NotificationTemplate < ActiveRecord::Base
	has_many :notifications
	@@dealer = Dealer.all

	def fill_up_service_booking_template(user, booking)
		a = 5
		self.content % { ServiceBooking_Day:booking.service_date, ServiceBooking_Weekday:a, ServiceBooking_Year:a, ServiceBooking_Month:a, ServiceBooking_Customer_Name:booking.my_bike.user.profile.full_name, vehicle:booking.my_bike.bike, ServiceBooking_Car_RegistrationNumber:booking.my_bike.registration_number, ServiceBooking_Date:booking.service_date, ServiceBooking_Time:booking.service_time, ServiceBooking_ServiceCenter_Name:booking.service_station, servicecenter_number:a, ServiceBooking_ServiceCenter_Number:a  }
	end

	#admin service booking mail
	def fill_keywords(notifiable, user = nil)

		case self.category
		when I18n.t('Notification.service_booking'), "Re-active sevice reminder notification"
			service_booking(notifiable)
		when I18n.t('Notification.service_booking_updated')
			service_booking_update(notifiable)
		when I18n.t('Notification.service_booking_destroyed')
			service_booking_delete(notifiable)
		when I18n.t('Notification.test_ride_booking'), I18n.t('Notification.test_ride_updated'), I18n.t('Notification.test_ride_destroyed'), 'Re-active test drive reminder notification'
			test_ride_booking(notifiable)
		when I18n.t('Notification.insurance_renewal'), "Insurance renewal in-app reminder notification"
			insurance_renewal_booking(notifiable)	
		when I18n.t('Notification.contact_us')	
			contact_us_notification(notifiable)
		when I18n.t('Notification.welcome')	
			welcome_notification(notifiable)
		when I18n.t('Notification.feedback')
			feedback_notification(notifiable)	
		when I18n.t('Notification.ride_created'), I18n.t('Notification.ride_updated'), I18n.t('Notification.ride_deleted'), I18n.t('Notification.ride_user_response')
			ride_notification(notifiable, user)	
		when I18n.t('Notification.event_created'), I18n.t('Notification.event_updated'), I18n.t('Notification.event_deleted'), I18n.t('Notification.event_user_response')
			event_notification(notifiable, user)
		when I18n.t('Notification.accessories')
			accessories_notification(notifiable)	
		when I18n.t('Notification.kms_exceeds'), I18n.t('Notification.service_reminder')
			service_booking_reactive(notifiable)
		when I18n.t('Notification.used_bike_enquiry')
			used_bike_enquiry(notifiable)
		when I18n.t('Notification.sell_bike_msg')
			sell_bike_notification(notifiable)	
		when "Value added service notification"
			value_added_service(notifiable)		
		else 
			[content, title]
		end	
	rescue StandardError => e
		logger.info e.message
		return ["Data is Deleted!","Data is Deleted!"]	
	end	

	def accessories_notification(acc)
		user = User.find_by_id acc.user_id
		acc_content = self.content % { customer_name:user.try(:profile).try(:full_name) }
		acc_title = self.title
		[acc_content, acc_title]
	end

	def value_added_service(enquiry)	
		contact_content = self.content % { customer_name: enquiry.name, customer_phone: enquiry.mobile, customer_email: enquiry.email, vehicle_model: enquiry.model, vehicle_purchase_date: enquiry.date_of_purchase, vehicle_registrationNo: enquiry.registration_number, vehicle_description: enquiry.description, vehicle_vas_name: enquiry.select_scheme }
		contact_tittle = self.title % { customer_name: enquiry.name, customer_phone: enquiry.mobile, customer_email: enquiry.email, vehicle_model: enquiry.model, vehicle_purchase_date: enquiry.date_of_purchase, vehicle_registrationNo: enquiry.registration_number, vehicle_description: enquiry.description, vehicle_vas_name: enquiry.select_scheme }
		[contact_content, contact_tittle]
	end

	
	def service_booking(service)
		@vehicle_model = service.my_bike.bike
		@pickup_request = service.request_pick_up
		@service_center = @@dealer.find_by_dealer_name(service.service_station)

		if @pickup_request == true
			@pickup_req = "You have selected for the vehicle to be picked up for the Service Booking at the time specified above.<br/>Address:<br/>#{@service_center.try(:address)}</br>"
		else
			@pickup_req = "You have indicated that you will bring the vehicle to our #{@service_center.try(:dealer_name)} showroom for the Service booking.<br/>
			Our #{@service_center.try(:dealer_name)} service center is located at<br/>#{@service_center.try(:address)}<br/>"
		end
		#ServiceBooking_Customer_Address, ServiceBooking_Customer_number
		#@n_template = EmailNotificationTemplate.find_by_category(booking_type)
		@service_content = self.content % { vehicle: service.my_bike.bike, ServiceBooking_Customer_Name:service.my_bike.user.profile.full_name, ServiceBooking_Customer_Email:service.my_bike.user.email, ServiceBooking_Customer_Address: "fsff sdfsdfsdf",  ServiceBooking_Customer_Number: "4534534534",  ServiceBooking_Car_Model:@vehicle_model, ServiceBooking_Date:service.service_date.strftime("%d/%m/%Y"), ServiceBooking_Time:service.service_time.strftime("%I:%M%p"), ServiceBooking_Car_RegistrationNumber:service.try(:registration_number), ServiceBooking_PickUp_Request:@pickup_req, ServiceBooking_ServiceCenter_Name:@service_center.try(:dealer_name), ServiceBooking_ServiceCenter_Number:@service_center.try(:mobile), servicecenter_number:@service_center.try(:mobile), ServiceBooking_PickUp_Address:@pickup_req,  ServiceBooking_Car_KmsRun:service.try(:kms), ServiceBooking_ServiceCenter_Address:@service_center.try(:address), ServiceBooking_Service_Type:service.try(:service_type), vehicle_kms:service.try(:kms), ServiceBooking_Customer_Comments:service.try(:comments), ServiceBooking_Day:service.service_date.strftime("%d").to_i.ordinalize, ServiceBooking_Month:service.service_date.strftime("%B"), ServiceBooking_Year:service.service_date.strftime("%Y"), ServiceBooking_Weekday:service.service_date.strftime("%A"), ServiceBooking_Object_id:service.id }
		@service_title = self.title % { ServiceBooking_Day:service.service_date.strftime("%d").to_i.ordinalize, ServiceBooking_Customer_Name:service.my_bike.user.profile.full_name, ServiceBooking_Customer_Email:service.my_bike.user.email, ServiceBooking_Car_Model:@vehicle_model, ServiceBooking_Date:service.service_date.strftime("%d/%m/%Y") }
		[@service_content, @service_title]
	end

	def service_booking_delete(service)
		@vehicle_model = service.my_bike.bike
		@service_center = @@dealer.find_by_dealer_name(service.service_station)

		@service_content = self.content % { vehicle: service.my_bike.bike, ServiceBooking_Customer_Name:service.my_bike.user.profile.full_name, ServiceBooking_Customer_Email:service.my_bike.user.email, ServiceBooking_Customer_Address: "fsff sdfsdfsdf",  ServiceBooking_Customer_Number: "4534534534",  ServiceBooking_Car_Model:@vehicle_model, ServiceBooking_Date:service.service_date.strftime("%d/%m/%Y"), ServiceBooking_Time:service.service_time.strftime("%I:%M%p"), ServiceBooking_Car_RegistrationNumber:service.try(:registration_number), ServiceBooking_ServiceCenter_Name:@service_center.try(:dealer_name), ServiceBooking_ServiceCenter_Number:@service_center.try(:mobile), servicecenter_number:@service_center.try(:mobile), ServiceBooking_PickUp_Address:@pickup_req,  ServiceBooking_Car_KmsRun:service.try(:kms), ServiceBooking_ServiceCenter_Address:@service_center.try(:address), ServiceBooking_Service_Type:service.try(:service_type), vehicle_kms:service.try(:kms), ServiceBooking_Customer_Comments:service.try(:comments), ServiceBooking_Day:service.service_date.strftime("%d").to_i.ordinalize, ServiceBooking_Month:service.service_date.strftime("%B"), ServiceBooking_Year:service.service_date.strftime("%Y"), ServiceBooking_Weekday:service.service_date.strftime("%A"), ServiceBooking_Object_id:service.id }
		@service_title = self.title % { ServiceBooking_Day:service.service_date.strftime("%d").to_i.ordinalize, ServiceBooking_Customer_Name:service.my_bike.user.profile.full_name, ServiceBooking_Customer_Email:service.my_bike.user.email, ServiceBooking_Car_Model:@vehicle_model, ServiceBooking_Date:service.service_date.strftime("%d/%m/%Y") }
		[@service_content, @service_title]
	end

	def service_booking_update(service)
		@vehicle_model = service.my_bike.bike
		@service_center = @@dealer.find_by_dealer_name(service.service_station)

		@service_content = self.content % { vehicle: service.my_bike.bike, ServiceBooking_Customer_Name:service.my_bike.user.profile.full_name, ServiceBooking_Customer_Email:service.my_bike.user.email, ServiceBooking_Customer_Address: "fsff sdfsdfsdf",  ServiceBooking_Customer_Number: "4534534534",  ServiceBooking_Car_Model:@vehicle_model, ServiceBooking_Date:service.service_date.strftime("%d/%m/%Y"), ServiceBooking_Time:service.service_time.strftime("%I:%M%p"), ServiceBooking_Car_RegistrationNumber:service.try(:registration_number), ServiceBooking_ServiceCenter_Name:@service_center.try(:dealer_name), ServiceBooking_ServiceCenter_Number:@service_center.try(:mobile), servicecenter_number:@service_center.try(:mobile), ServiceBooking_PickUp_Address:@pickup_req,  ServiceBooking_Car_KmsRun:service.try(:kms), ServiceBooking_ServiceCenter_Address:@service_center.try(:address), ServiceBooking_Service_Type:service.try(:service_type), vehicle_kms:service.try(:kms), ServiceBooking_Customer_Comments:service.try(:comments), ServiceBooking_Day:service.service_date.strftime("%d").to_i.ordinalize, ServiceBooking_Month:service.service_date.strftime("%B"), ServiceBooking_Year:service.service_date.strftime("%Y"), ServiceBooking_Weekday:service.service_date.strftime("%A"), ServiceBooking_Object_id: service.id }
		@service_title = self.title % { ServiceBooking_Day:service.service_date.strftime("%d").to_i.ordinalize, ServiceBooking_Customer_Name:service.my_bike.user.profile.full_name, ServiceBooking_Customer_Email:service.my_bike.user.email, ServiceBooking_Car_Model:@vehicle_model, ServiceBooking_Date:service.service_date.strftime("%d/%m/%Y") }
		[@service_content, @service_title]
	end

	def test_ride_booking(test_ride)
		@vehicle_model = test_ride.bike
		@showroom = @@dealer.find_by_dealer_name(test_ride.location)
		@pickup_request = test_ride.request_pick_up
		if @pickup_request == true
			@pickup_request = "Yes"
			@pickup_req = "You have selected for the vehicle to be brought home for the Test Drive <br/>
			Address:</br>
			#{test_ride.try(:address)}<br/>"
		else
			@pickup_req = "You have indicated that you will come to our #{test_ride.try(:sales_center)} showroom for the Test Drive<br/>Our #{@showroom.try(:dealer_name)} showroom is located at <br/>
			#{@showroom.try(:address)}<br/>"
			@pickup_request = "No"
		end

		test_ride_content = self.content % { TestDriveBooking_Customer_Name:test_ride.try(:name), TestDriveBooking_Car_Model:@vehicle_model, TestDriveBooking_Date:test_ride.ride_date.strftime("%d/%m/%Y"), TestDriveBooking_Time:test_ride.ride_time.strftime("%I:%M%p"), TestDriveBooking_Showroom_Address:@showroom.try(:address),  TestDriveBooking_Showroom_Name:@showroom.try(:dealer_name), TestDriveBooking_Showroom_Number: @showroom.try(:mobile),TestDriveBooking_Customer_Number:test_ride.try(:mobile), TestDriveBooking_Customer_Email:test_ride.try(:email), TestDriveBooking_Customer_Address:test_ride.try(:address), TestDriveBooking_PickUp_Request:@pickup_req, TestDriveBook_PickUp_Address:@pickup_req, TestDriveBooking_Day:test_ride.ride_date.strftime("%d").to_i.ordinalize, TestDriveBooking_Month:test_ride.ride_date.strftime("%B"), TestDriveBooking_Year:test_ride.ride_date.strftime("%Y"), TestDriveBooking_Weekday:test_ride.ride_date.strftime("%A"), TestDriveBooking_update_time: test_ride.ride_time.strftime("%I:%M%p"), Test_Ride_Object_Id: test_ride.id }
		test_ride_title = self.title % { TestDriveBooking_Date:test_ride.ride_date.strftime("%d/%m/%Y") }
		[test_ride_content, test_ride_title]
	end

	def insurance_renewal_booking(insurance)
		logger.info "======================#{insurance.inspect}"
		vehicle_name = insurance.bike
		@insurance_renewal = insurance
		if vehicle_name == insurance.bike.to_i.to_s
			@vehicle_model = MyBike.find_by_id(insurance.bike).try(:bike) || 'N/A'
		else
			@vehicle_model = insurance.bike
		end
		#InsuranceRenewal_Car_ManufactureYear
		ex_date = Date.parse(insurance.expiry_date)
		ins_content = self.content % { InsuranceRenewal_Customer_Name:insurance.name, InsuranceRenewal_Car_Model:@vehicle_model, InsuranceRenewal_Car_RegistrationNumber:insurance.registration_number, InsuranceRenewal_Customer_Address:insurance.address, InsuranceRenewal_Customer_Number:insurance.mobile, InsuranceRenewal_Customer_Email:insurance.email, InsuranceRenewal_Policy_Number:insurance.policy_number, InsuranceRenewal_Policy_Company:insurance.insurance_company, vehicle_year:insurance.purchase_date.strftime("%Y"), InsuranceRenewal_Policy_ExpiryDate:insurance.expiry_date, day:ex_date.strftime("%d").to_i.ordinalize, month:ex_date.strftime("%B"), year:ex_date.strftime("%Y"), weekday:ex_date.strftime("%A"), vehicle_kms:insurance.kms }
		ins_title = self.title  % { InsuranceRenewal_Customer_Name:insurance.name, InsuranceRenewal_Car_Model:@vehicle_model, InsuranceRenewal_Car_RegistrationNumber:insurance.registration_number, InsuranceRenewal_Customer_Address:insurance.address, InsuranceRenewal_Customer_Number:insurance.mobile, InsuranceRenewal_Customer_Email:insurance.email, InsuranceRenewal_Policy_Number:insurance.policy_number, InsuranceRenewal_Policy_Company:insurance.insurance_company, vehicle_year:insurance.purchase_date.strftime("%Y"), InsuranceRenewal_Policy_ExpiryDate:insurance.expiry_date, day:ex_date.strftime("%d").to_i.ordinalize, month:ex_date.strftime("%B"), year:ex_date.strftime("%Y"), weekday:ex_date.strftime("%A"), vehicle_kms:insurance.kms }
		[ins_content, ins_title]
	end

	def contact_us_notification(contact)
		contact_content = self.content % { ContactUs_Customer_Name: contact.name, ContactUs_Customer_Number: contact.phone, ContactUs_Customer_Email: contact.email, ContactUs_Dealerership_Name: contact.dealer_location, ContactUs_AreaOfEnquiry: contact.category, ContactUs_Comment: contact.message, ContactUs_bike: enquiry.bike}
		contact_tittle = self.title % { ContactUs_AreaOfEnquiry:contact.category }
		[contact_content, contact_tittle]
	end	

	def welcome_notification(user)
		logger.info "===========#{user.inspect}"
		user.reload
		logger.info "===========#{user.profile.inspect}"

		welcome_content = self.content % {Welcome_Customer_Name:user.profile.full_name}
		welcome_title = self.title 
		[welcome_content, welcome_title]
	end

	def feedback_notification(feedback)
		feedback_content = self.content || 'N/A'
		feedback_title = self.title || 'N/A'
		[feedback_content, feedback_title]
	end

	def ride_notification(ride, user)
		user_ride = user.user_rides.where(ride_id: ride.id).first
		ride_content = self.content % {Ride_Customer_Name: user.try(:profile).try(:full_name), Ride_Final_Destination: ride.destination_location, Ride_date: ride.ride_date, Ride_Object_ID: user_ride.id, coordinator_name: ride.coordinator_name, coordinator_mobile: ride.coordinator_mobile}
		ride_title = self.title % {Ride_date: ride.ride_date}
		[ride_content, ride_title]
	end	

	def event_notification(event, user)
		user_event = user.user_events.where(event_id: event.id).first
		event_content = self.content % {Event_Customer_Name: user.try(:profile).try(:full_name), Event_Final_Destination: event.location, Event_date: event.event_date, Event_Object_ID: user_event.id, coordinator_name: event.coordinator_name, coordinator_mobile: event.coordinator_mobile}
		event_title = self.title % {Event_date: event.event_date}
		[event_content, event_title]
	end	

	def used_bike_enquiry(used_vehicle_enquiry)
		used_bike_content = self.content % { customer_name:used_vehicle_enquiry.name, customer_email:used_vehicle_enquiry.email, customer_address:used_vehicle_enquiry.address, customer_number:used_vehicle_enquiry.mobile, dealer_name:used_vehicle_enquiry.dealer_location, car:used_vehicle_enquiry.model, vehicle_year:used_vehicle_enquiry.manufacture_year, vehicle_price:used_vehicle_enquiry.price, content:used_vehicle_enquiry.comment, ContactUs_Comment:used_vehicle_enquiry.comment, car_kms:used_vehicle_enquiry.kms, registration_number:used_vehicle_enquiry.registration_number, dealer_number:used_vehicle_enquiry.dealer_number }
		used_bike_tittle = self.title % { customer_name:used_vehicle_enquiry.name, customer_email:used_vehicle_enquiry.email, customer_address:used_vehicle_enquiry.address, customer_number:used_vehicle_enquiry.mobile, dealer_name:used_vehicle_enquiry.dealer_location, car:used_vehicle_enquiry.model, vehicle_year:used_vehicle_enquiry.manufacture_year, vehicle_price:used_vehicle_enquiry.price, content:used_vehicle_enquiry.comment, ContactUs_Comment:used_vehicle_enquiry.comment, car_kms:used_vehicle_enquiry.kms, registration_number:used_vehicle_enquiry.registration_number, dealer_number:used_vehicle_enquiry.dealer_number }
		
		[used_bike_content, used_bike_tittle]
	end	

	def sell_bike_notification(sell_bike)
		user = User.find_by_id(sell_bike.user_id)
		sell_bike.make_coompany.present? ? make_name = sell_bike.make_coompany : make_name = sell_bike.used_bike_model.name
		sell_bike_content = self.content % { customer_name:user.try(:profile).try(:full_name), customer_email:user.email, vehicle_type:sell_bike.bike_type, customer_phone:user.try(:profile).try(:mobile), vehicle_make: make_name, vehicle_year:sell_bike.manufacture_year, vehicle_quotedPrice:sell_bike.price, vehicle_colour: sell_bike.color, vehicle_kms: sell_bike.kms, vehicle_registrationNo: sell_bike.registration_number, vehicle_gears: sell_bike.gear, vehicle_model: sell_bike.model, excahnge_bike: sell_bike.exchange }
		sell_bike_title = self.title % { customer_name:user.try(:profile).try(:full_name), customer_email:user.email, vehicle_type:sell_bike.bike_type, customer_phone:user.try(:profile).try(:mobile), vehicle_make: make_name, vehicle_year:sell_bike.manufacture_year, vehicle_quotedPrice:sell_bike.price, vehicle_colour: sell_bike.color, vehicle_kms: sell_bike.kms, vehicle_registrationNo: sell_bike.registration_number, vehicle_gears: sell_bike.gear, vehicle_model: sell_bike.model, excahnge_bike: sell_bike.exchange }
		
		[sell_bike_content, sell_bike_title]
	end

	def service_created_at
		self.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end
	def service_updated_at
		self.updated_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end		

	def as_json(options={})
		super.as_json(options).merge({ created_at: service_created_at, updated_at: service_updated_at })
	end	

end
