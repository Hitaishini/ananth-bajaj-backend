class BulkNotification < ApplicationRecord
    has_many :notifications
	mount_base64_uploader :image, ImageUploader, file_name: 'notification'

	def fill_keywords(notifiable, user = nil)
		case self.category
		when I18n.t('Notification.service_booking')
			service_booking(notifiable)
		when I18n.t('Notification.service_booking_updated')
			service_booking_update(notifiable)
		when I18n.t('Notification.service_booking_destroyed')
			service_booking_delete(notifiable)
		when I18n.t('Notification.test_ride_booking'), I18n.t('Notification.test_ride_updated'), I18n.t('Notification.test_ride_destroyed')
			test_ride_booking(notifiable)
		when I18n.t('Notification.insurance_renewal')
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
		else
			[content, title]
		end	
	end	

	def service_booking(service)
  	@vehicle_model = service.my_bike.bike
  	@pickup_request = service.request_pick_up
  	@service_center = @@dealer.find_by_dealer_name(service.service_station)
  	showroom_number = DealerContactNumber.where(dealer_contact_label_id: DealerContactLabel.where(label_name: "Service 1").first.id).first.number

  	if @pickup_request == true
			@pickup_req = "You have selected for the vehicle to be picked up for the Service Booking at the time specified above.<br/>Address:<br/>#{@service_center.try(:address)}</br>"
		else
			@pickup_req = "You have indicated that you will bring the vehicle to our #{@service_center.try(:dealer_name)} showroom for the Service booking.<br/>
		Our #{@service_center.try(:dealer_name)} service center is located at<br/>#{@service_center.try(:address)}<br/>"
		end
		#ServiceBooking_Customer_Address, ServiceBooking_Customer_number
		#@n_template = EmailNotificationTemplate.find_by_category(booking_type)
		@service_content = self.content % { vehicle: service.my_bike.bike, ServiceBooking_Customer_Name:service.my_bike.user.profile.full_name, ServiceBooking_Customer_Email:service.my_bike.user.email, ServiceBooking_Customer_Address: "fsff sdfsdfsdf",  ServiceBooking_Customer_Number: "4534534534",  ServiceBooking_Car_Model:@vehicle_model, ServiceBooking_Date:service.service_date.strftime("%d/%m/%Y"), ServiceBooking_Time:service.service_time.strftime("%I:%M%p"), ServiceBooking_Car_RegistrationNumber:service.try(:registration_number), ServiceBooking_PickUp_Request:@pickup_req, ServiceBooking_ServiceCenter_Name:@service_center.try(:dealer_name), ServiceBooking_ServiceCenter_Number:showroom_number, servicecenter_number:showroom_number, ServiceBooking_PickUp_Address:@pickup_req,  ServiceBooking_Car_KmsRun:service.try(:kms), ServiceBooking_ServiceCenter_Address:@service_center.try(:address), ServiceBooking_Service_Type:service.try(:service_type), vehicle_kms:service.try(:kms), ServiceBooking_Customer_Comments:service.try(:comments), ServiceBooking_Day:service.service_date.strftime("%d").to_i.ordinalize, ServiceBooking_Month:service.service_date.strftime("%B"), ServiceBooking_Year:service.service_date.strftime("%Y"), ServiceBooking_Weekday:service.service_date.strftime("%A"), ServiceBooking_Object_id: service.id }
		@service_title = self.title % { ServiceBooking_Day:service.service_date.strftime("%d").to_i.ordinalize, ServiceBooking_Customer_Name:service.my_bike.user.profile.full_name, ServiceBooking_Customer_Email:service.my_bike.user.email, ServiceBooking_Car_Model:@vehicle_model, ServiceBooking_Date:service.service_date.strftime("%d/%m/%Y") }
		[@service_content, @service_title]
	end

	def service_booking_delete(service)
		@vehicle_model = service.my_bike.try(:bike)
		@service_center = @@dealer.find_by_dealer_name(service.service_station)
		showroom_number = DealerContactNumber.where(dealer_contact_label_id: DealerContactLabel.where(label_name: "Service 1").first.id).first.number

		@service_content = self.content % { vehicle: service.my_bike.try(:bike), ServiceBooking_Customer_Name:service.my_bike.user.profile.full_name, ServiceBooking_Customer_Email:service.my_bike.user.email, ServiceBooking_Customer_Address: "fsff sdfsdfsdf",  ServiceBooking_Customer_Number: "4534534534",  ServiceBooking_Car_Model:@vehicle_model, ServiceBooking_Date:service.service_date.strftime("%d/%m/%Y"), ServiceBooking_Time:service.service_time.strftime("%I:%M%p"), ServiceBooking_Car_RegistrationNumber:service.try(:registration_number), ServiceBooking_ServiceCenter_Name:@service_center.try(:dealer_name), ServiceBooking_ServiceCenter_Number:showroom_number, servicecenter_number:showroom_number, ServiceBooking_PickUp_Address:@pickup_req,  ServiceBooking_Car_KmsRun:service.try(:kms), ServiceBooking_ServiceCenter_Address:@service_center.try(:address), ServiceBooking_Service_Type:service.try(:service_type), vehicle_kms:service.try(:kms), ServiceBooking_Customer_Comments:service.try(:comments), ServiceBooking_Day:service.service_date.strftime("%d").to_i.ordinalize, ServiceBooking_Month:service.service_date.strftime("%B"), ServiceBooking_Year:service.service_date.strftime("%Y"), ServiceBooking_Object_id: service.id, ServiceBooking_Weekday:service.service_date.strftime("%A") }
		@service_title = self.title % { ServiceBooking_Day:service.service_date.strftime("%d").to_i.ordinalize, ServiceBooking_Customer_Name:service.my_bike.user.profile.full_name, ServiceBooking_Customer_Email:service.my_bike.user.email, ServiceBooking_Car_Model:@vehicle_model, ServiceBooking_Date:service.service_date.strftime("%d/%m/%Y") }
		[@service_content, @service_title]
	end

	def service_booking_update(service)
		@vehicle_model = service.my_bike.bike
		@service_center = @@dealer.find_by_dealer_name(service.service_station)
		showroom_number = DealerContactNumber.where(dealer_contact_label_id: DealerContactLabel.where(label_name: "Service 1").first.id).first.number

		@service_content = self.content % { vehicle: service.my_bike.bike, ServiceBooking_Customer_Name:service.my_bike.user.profile.full_name, ServiceBooking_Customer_Email:service.my_bike.user.email, ServiceBooking_Customer_Address: "fsff sdfsdfsdf",  ServiceBooking_Customer_Number: "4534534534",  ServiceBooking_Car_Model:@vehicle_model, ServiceBooking_Date:service.service_date.strftime("%d/%m/%Y"), ServiceBooking_Time:service.service_time.strftime("%I:%M%p"), ServiceBooking_Car_RegistrationNumber:service.try(:registration_number), ServiceBooking_ServiceCenter_Name:@service_center.try(:dealer_name), ServiceBooking_ServiceCenter_Number:showroom_number, servicecenter_number:showroom_number, ServiceBooking_PickUp_Address:@pickup_req,  ServiceBooking_Car_KmsRun:service.try(:kms), ServiceBooking_ServiceCenter_Address:@service_center.try(:address), ServiceBooking_Service_Type:service.try(:service_type), vehicle_kms:service.try(:kms), ServiceBooking_Customer_Comments:service.try(:comments), ServiceBooking_Day:service.service_date.strftime("%d").to_i.ordinalize, ServiceBooking_Month:service.service_date.strftime("%B"), ServiceBooking_Year:service.service_date.strftime("%Y"), ServiceBooking_Object_id: service.id, ServiceBooking_Weekday:service.service_date.strftime("%A") }
		@service_title = self.title % { ServiceBooking_Day:service.service_date.strftime("%d").to_i.ordinalize, ServiceBooking_Customer_Name:service.my_bike.user.profile.full_name, ServiceBooking_Customer_Email:service.my_bike.user.email, ServiceBooking_Car_Model:@vehicle_model, ServiceBooking_Date:service.service_date.strftime("%d/%m/%Y") }
		[@service_content, @service_title]
	end

	def test_ride_booking(test_ride)
		@vehicle_model = test_ride.bike
		@showroom = @@dealer.find_by_dealer_name(I18n.t('Dealer.name'))
		showroom_number = DealerContactNumber.where(dealer_contact_label_id: DealerContactLabel.where(label_name: "Service 1").first.id).first.number
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
		
		test_ride_content = self.content % { TestDriveBooking_Customer_Name:test_ride.try(:name), TestDriveBooking_Car_Model:@vehicle_model, TestDriveBooking_Date:test_ride.ride_date.strftime("%d/%m/%Y"), TestDriveBooking_Time:test_ride.ride_time.strftime("%I:%M%p"), TestDriveBooking_Showroom_Address:@showroom.try(:address),  TestDriveBooking_Showroom_Name:@showroom.dealer_name, TestDriveBooking_Showroom_Number: showroom_number, TestDriveBooking_Customer_Number:test_ride.try(:mobile), TestDriveBooking_Customer_Email:test_ride.try(:email), TestDriveBooking_Customer_Address:test_ride.try(:address), TestDriveBooking_PickUp_Request:@pickup_req, TestDriveBook_PickUp_Address:@pickup_req, TestDriveBooking_Day:test_ride.ride_date.strftime("%d").to_i.ordinalize, TestDriveBooking_Month:test_ride.ride_date.strftime("%B"), TestDriveBooking_Year:test_ride.ride_date.strftime("%Y"), TestDriveBooking_Weekday:test_ride.ride_date.strftime("%A"), Test_Ride_Object_Id: test_ride.id }
		test_ride_title = self.title % { TestDriveBooking_Date:test_ride.ride_date.strftime("%d/%m/%Y") }
		[test_ride_content, test_ride_title]
	end

	def insurance_renewal_booking(insurance)
		@vehicle_model = insurance.bike
		@insurance_renewal = insurance
		#InsuranceRenewal_Car_ManufactureYear
		ex_date = Date.parse(insurance.expiry_date)
		ins_content = self.content % { InsuranceRenewal_Customer_Name:insurance.name, InsuranceRenewal_Car_Model:insurance.bike, InsuranceRenewal_Car_RegistrationNumber:insurance.registration_number, InsuranceRenewal_Customer_Address:insurance.address, InsuranceRenewal_Customer_Number:insurance.mobile, InsuranceRenewal_Customer_Email:insurance.email, InsuranceRenewal_Policy_Number:insurance.policy_number, InsuranceRenewal_Policy_Company:insurance.insurance_company, vehicle_year:insurance.purchase_date.strftime("%Y"), InsuranceRenewal_Policy_ExpiryDate:insurance.expiry_date, day:ex_date.strftime("%d").to_i.ordinalize, month:ex_date.strftime("%B"), year:ex_date.strftime("%Y"), weekday:ex_date.strftime("%A"), vehicle_kms:insurance.kms }
		ins_title = self.title  % { InsuranceRenewal_Customer_Name:insurance.name, InsuranceRenewal_Car_Model:insurance.bike, InsuranceRenewal_Car_RegistrationNumber:insurance.registration_number, InsuranceRenewal_Customer_Address:insurance.address, InsuranceRenewal_Customer_Number:insurance.mobile, InsuranceRenewal_Customer_Email:insurance.email, InsuranceRenewal_Policy_Number:insurance.policy_number, InsuranceRenewal_Policy_Company:insurance.insurance_company, vehicle_year:insurance.purchase_date.strftime("%Y"), InsuranceRenewal_Policy_ExpiryDate:insurance.expiry_date, day:ex_date.strftime("%d").to_i.ordinalize, month:ex_date.strftime("%B"), year:ex_date.strftime("%Y"), weekday:ex_date.strftime("%A"), vehicle_kms:insurance.kms }
		[ins_content, ins_title]
	end

	def contact_us_notification(contact)
		contact_content = self.content % {ContactUs_AreaOfEnquiry:contact.try(:category), ContactUs_Comment: contact.message}
		contact_tittle = self.title % { ContactUs_AreaOfEnquiry:contact.category }
		[contact_content, contact_tittle]
	end	

	def welcome_notification(user)
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

end
