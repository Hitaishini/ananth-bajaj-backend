require 'active_support/builder' unless defined?(Builder)
class UserMailer < ApplicationMailer
	layout false
	default from: "support@anantbajaj.com"

	@@dealer = Dealer.all
	@@setmail = SetMail.all

	def test_mail(email)
		mail :to => email, :subject => "Test Mail from Anant", body: "Test Mail"
	end

	def password_reset(user)
		@user = user
		mail :to => user.email, :subject => "Password Reset link for Anant Bajaj Website"
	end

	def password_reset_success(user)
		@n_template = SetNotificationTemplate.find_by_category("Password reset success mail-user")
		@password_reset_confirm_user = @n_template.template % {Welcome_Customer_Name:user.name, Welcome_Customer_Email:user.email, Welcome_Customer_Number:user.mobile }
		@subject = @n_template.title % { Welcome_Customer_Name:user.name, Welcome_Customer_Email:user.email, Welcome_Customer_Number:user.mobile }
		mail :to => user.email, :subject => @subject, :body => @password_reset_confirm_user
	end

	def test_ride_booking(testride, notification_type, params)
		@vehicle_model = testride.bike
		@showroom = @@dealer.find_by_dealer_name(testride.location)

		@mail_list = @@setmail.where(category: "Test drive booking", location: testride.location).first || @@setmail.where(category: "Test drive booking").first
		#@mail_list = @@setmail.find_by_category("Test drive booking")
		@pickup_request = testride.request_pick_up
		if @pickup_request == true
			@pickup_req = "Yes"
			@address = testride.address
		else
			@pickup_req = "No"
		end
		#key words
		# fuel_type:testride.fuel_type, TestDriveBooking_Showroom_Number:@showroom.mobile,
		logger.info "========================#{notification_type}"
		@coramandal_template = EmailNotificationTemplate.find_by_category(notification_type)
		@testride_confirm_dealer = @coramandal_template.content % { TestDriveBooking_Customer_Name:testride.try(:name), TestDriveBooking_Car_Model:@vehicle_model, TestDriveBooking_Showroom_Number:@showroom.try(:mobile), TestDriveBooking_Date:testride.ride_date.strftime("%d/%m/%Y"), TestDriveBooking_Time:testride.ride_time.strftime("%I:%M%p"), TestDriveBooking_Showroom_Address:@showroom.try(:address),  TestDriveBooking_Showroom_Name:@showroom.try(:dealer_name), TestDriveBooking_Customer_Number:testride.try(:mobile), TestDriveBooking_Customer_Email:testride.try(:email), TestDriveBooking_Customer_Address:testride.try(:address), TestDriveBooking_PickUp_Request:@pickup_req, TestDriveBook_PickUp_Address:@pickup_req, TestDriveBooking_Day:testride.ride_date.strftime("%d").to_i.ordinalize, TestDriveBooking_Month:testride.ride_date.strftime("%B"), TestDriveBooking_Year:testride.ride_date.strftime("%Y"), TestDriveBooking_Weekday:testride.ride_date.strftime("%A") }
		@subject = @coramandal_template.title % { TestDriveBooking_Customer_Name:testride.try(:name), TestDriveBooking_Car_Model:@vehicle_model, TestDriveBooking_Showroom_Number:@showroom.try(:mobile), TestDriveBooking_Date:testride.ride_date.strftime("%d/%m/%Y"), TestDriveBooking_Time:testride.ride_time.strftime("%I:%M%p"), TestDriveBooking_Showroom_Address:@showroom.try(:address),  TestDriveBooking_Showroom_Name:@showroom.try(:dealer_name), TestDriveBooking_Customer_Number:testride.try(:mobile), TestDriveBooking_Customer_Email:testride.try(:email), TestDriveBooking_Customer_Address:testride.try(:address), TestDriveBooking_PickUp_Request:@pickup_req, TestDriveBook_PickUp_Address:@pickup_req, TestDriveBooking_Day:testride.ride_date.strftime("%d").to_i.ordinalize, TestDriveBooking_Month:testride.ride_date.strftime("%B"), TestDriveBooking_Year:testride.ride_date.strftime("%Y"), TestDriveBooking_Weekday:testride.ride_date.strftime("%A") }

		mail :to => @mail_list.email, :subject => @subject
	end

	def testride_request_confirm(testride, notification_type)
		@vehicle_model = testride.bike
		@showroom = @@dealer.find_by_dealer_name(testride.location)
		@pickup_request = testride.request_pick_up
		if @pickup_request == true
			@pickup_request = "Yes"
			@pickup_req = "You have selected for the vehicle to be brought home for the Test Drive <br/>
			Address:</br>
			#{testride.try(:address)}<br/>"
		else
			@pickup_req = "You have indicated that you will come to our #{testride.try(:sales_center)} showroom for the Test Drive<br/>Our #{@showroom.try(:dealer_name)} showroom is located at <br/>
			#{@showroom.try(:address)}<br/>"
			@pickup_request = "No"
		end
		@coramandal_template = EmailNotificationTemplate.find_by_category(notification_type)
		@testdrive_confirm_user = @coramandal_template.content % { TestDriveBooking_Customer_Name:testride.try(:name), TestDriveBooking_Car_Model:@vehicle_model, TestDriveBooking_Date:testride.ride_date.strftime("%d/%m/%Y"), TestDriveBooking_Showroom_Number:@showroom.try(:mobile), TestDriveBooking_Time:testride.ride_time.strftime("%I:%M%p"), TestDriveBooking_Showroom_Address:@showroom.try(:address),  TestDriveBooking_Showroom_Name:@showroom.try(:dealer_name), TestDriveBooking_Customer_Number:testride.try(:mobile), TestDriveBooking_Customer_Email:testride.try(:email), TestDriveBooking_Customer_Address:testride.try(:address), TestDriveBooking_PickUp_Request:@pickup_req, TestDriveBook_PickUp_Address:@pickup_req, TestDriveBooking_Day:testride.ride_date.strftime("%d").to_i.ordinalize, TestDriveBooking_Month:testride.ride_date.strftime("%B"), TestDriveBooking_Year:testride.ride_date.strftime("%Y"), TestDriveBooking_Weekday:testride.ride_date.strftime("%A") }
		@subject = @coramandal_template.title % { TestDriveBooking_Customer_Name:testride.try(:name), TestDriveBooking_Car_Model:@vehicle_model, TestDriveBooking_Date:testride.ride_date.strftime("%d/%m/%Y"), TestDriveBooking_Showroom_Number:@showroom.try(:mobile), TestDriveBooking_Time:testride.ride_time.strftime("%I:%M%p"), TestDriveBooking_Showroom_Address:@showroom.try(:address),  TestDriveBooking_Showroom_Name:@showroom.try(:dealer_name), TestDriveBooking_Customer_Number:testride.try(:mobile), TestDriveBooking_Customer_Email:testride.try(:email), TestDriveBooking_Customer_Address:testride.try(:address), TestDriveBooking_PickUp_Request:@pickup_req, TestDriveBook_PickUp_Address:@pickup_req, TestDriveBooking_Day:testride.ride_date.strftime("%d").to_i.ordinalize, TestDriveBooking_Month:testride.ride_date.strftime("%B"), TestDriveBooking_Year:testride.ride_date.strftime("%Y"), TestDriveBooking_Weekday:testride.ride_date.strftime("%A") }

		unless testride.status == 'Canceled'

			dt = calculate_ical_time(testride.ride_date, testride.ride_time)
			cal = Icalendar::Calendar.new
			cal.event do |e|
				e.dtstart = Icalendar::Values::DateTime.new dt
				e.dtend   = Icalendar::Values::DateTime.new dt + 1.hour#testride.ride_time + 1.hour
				e.summary     = "Anant Bajaj"
				e.description = "Test drive booking request with Anant Bajaj"
				e.ip_class    = "PRIVATE"
				e.alarm do |a|
					a.action        = "AUDIO"
					a.trigger       = "-PT60M"
					a.append_attach "Test drive booking request with Anant Bajaj"
				end
			end
			attachments['event.ics'] = cal.to_ical
		end	

		mail :to => testride.email, :subject => @subject
	end

  #admin service booking mail
  def service_booking(service, booking_type, params)
  	logger.info "=======Dealer Service Booking Email Notification========"
  	if service.my_bike.present?
  		@vehicle_model = service.my_bike.bike
  	else
  		if params[:id]
  			@vehicle_model = "nil"
  		else
  			@vehicle_model = params[:service_booking][:model]
  		end
  	end
  	user_profile = service.my_bike.try(:user).try(:profile)
  	@pickup_request = service.request_pick_up
  	if @pickup_request == true
  		@pickup_req = "Yes"
  		customer_address = user_profile.try(:address)
  	else
  		@pickup_req = "No"
  		customer_address = "N/A"
  	end

  	@service_center = @@dealer.find_by_dealer_name(service.service_station)
  	@mail_list = @@setmail.where(category: "Service booking", location: service.service_station).first || @@setmail.where(category: "Service booking").first

  	#@mail_list = @@setmail.find_by_category("Service booking")
		#ServiceBooking_Customer_Address, ServiceBooking_Customer_number
		@n_template = EmailNotificationTemplate.find_by_category(booking_type)
		@service_confirm_dealer = @n_template.content % { ServiceBooking_Customer_Name: service.user.try(:profile).try(:full_name), ServiceBooking_Customer_Email:service.user.try(:email), ServiceBooking_Customer_Address: customer_address,  ServiceBooking_Customer_Number: service.user.try(:profile).try(:mobile),  ServiceBooking_Car_Model:@vehicle_model, ServiceBooking_Date:service.service_date.strftime("%d/%m/%Y"), ServiceBooking_Time:service.service_time.strftime("%I:%M%p"), ServiceBooking_Car_RegistrationNumber:service.try(:registration_number), ServiceBooking_PickUp_Request:@pickup_req, ServiceBooking_ServiceCenter_Name:@service_center.try(:dealer_name), ServiceBooking_ServiceCenter_Number:@service_center.try(:mobile),  ServiceBooking_PickUp_Address:@pickup_req,  ServiceBooking_Car_KmsRun:service.try(:kms), ServiceBooking_ServiceCenter_Address:@service_center.try(:address), ServiceBooking_Service_Type:service.try(:service_type), vehicle_kms:service.try(:kms), ServiceBooking_Customer_Comments:service.try(:comments), ServiceBooking_Day:service.service_date.strftime("%d").to_i.ordinalize, ServiceBooking_Month:service.service_date.strftime("%B"), ServiceBooking_Yea:service.service_date.strftime("%Y"), ServiceBooking_Weekday:service.service_date.strftime("%A") }
		@subject = @n_template.title % { ServiceBooking_Customer_Name:service.try(:name), ServiceBooking_Customer_Email:service.email, ServiceBooking_Car_Model:@vehicle_model }

		mail :to => @mail_list.email, :subject => @subject
	end

#mail for user service booking confirmation
def service_request_confirm(service, booking_type, params)
	if service.my_bike.present?
		@vehicle_model = service.my_bike.bike
	else
		if params[:id]
			@vehicle_model = "nil"
		else
			@vehicle_model = params[:service_booking][:model]
		end
	end
	@service_center = @@dealer.find_by_dealer_name(service.service_station)
	@pickup_request = service.request_pick_up
	if @pickup_request == true
		@pickup_req = "You have selected for the vehicle to be picked up for the Service Booking at the time specified above.<br/>Address:<br/>#{@service_center.try(:address)}</br>"
	else
		@pickup_req = "You have indicated that you will bring the vehicle to our #{@service_center.try(:dealer_name)} showroom for the Service .<br/>
		Our #{@service_center.try(:dealer_name)} service center is located at<br/>#{@service_center.try(:address)}<br/>"
	end
    #keywords for service booking
    #customer_number:service.try(:mobile), customer_address:service.try(:address),
    @n_template = EmailNotificationTemplate.find_by_category(booking_type)
    @service_confirm_user = @n_template.content % { ServiceBooking_Customer_Name:service.name, ServiceBooking_Customer_Email:service.email, ServiceBooking_Car_Model:@vehicle_model, ServiceBooking_Customer_Address: "sdfsdfdsfs dsfsd", ServiceBooking_Customer_Number: service.try(:mobile), ServiceBooking_Date:service.service_date.strftime("%d/%m/%Y"), ServiceBooking_Time:service.service_time.strftime("%I:%M%p"), ServiceBooking_Car_RegistrationNumber:service.try(:registration_number), ServiceBooking_PickUp_Request:@pickup_req, ServiceBooking_ServiceCenter_Name:@service_center.try(:dealer_name), ServiceBooking_ServiceCenter_Number:@service_center.try(:mobile),  ServiceBooking_PickUp_Address:@pickup_req,  ServiceBooking_Car_KmsRun:service.try(:kms), ServiceBooking_ServiceCenter_Address:@service_center.try(:address), ServiceBooking_Service_Type:service.try(:service_type), vehicle_kms:service.try(:kms), ServiceBooking_Customer_Comments:service.try(:comments), ServiceBooking_Day:service.service_date.strftime("%d").to_i.ordinalize, ServiceBooking_Month:service.service_date.strftime("%B"), ServiceBooking_Year:service.service_date.strftime("%Y"), ServiceBooking_Weekday:service.service_date.strftime("%A") }  

    @subject = @n_template.title % { ServiceBooking_Customer_Name:service.try(:name), ServiceBooking_Customer_Email:service.email, ServiceBooking_Car_Model:@vehicle_model, ServiceBooking_ServiceCenter_Name:@service_center.try(:dealer_name) } 
    
    unless service.status == 'Canceled'
    	dt = calculate_ical_time(service.service_date, service.service_time)
    	cal = Icalendar::Calendar.new
    	cal.event do |e|
    		e.dtstart = Icalendar::Values::DateTime.new dt 
    		e.dtend   = Icalendar::Values::DateTime.new dt + 1.hour
    		e.summary     = service.service_station
    		e.description = "Service booking request with #{service.service_station}"
    		e.ip_class    = "PRIVATE"
    		e.alarm do |a|
    			a.action        = "AUDIO"
    			a.trigger       = "-PT60M"
    			a.append_attach "Service booking request with #{service.service_station}"
    		end
    	end
    	attachments['event.ics'] = cal.to_ical
    end	

    mail :to => service.email, :subject => @subject
end

def insurance_renewal(insurance)
	@vehicle_model = insurance.bike
	@insurance_renewal = insurance
	@mail_list = @@setmail.find_by_category("Insurance renewal")
	#InsuranceRenewal_Car_ManufactureYear
	if insurance.bike
		bike_name = MyBike.find_by_id(insurance.bike).try(:bike)
	end
	ex_date = Date.parse(insurance.expiry_date)

	@n_template = EmailNotificationTemplate.find_by_category("Insurance renewal mail-dealer")
	@insurance_request_dealer = @n_template.content % { InsuranceRenewal_Kms:insurance.kms, InsuranceRenewal_Customer_Name:insurance.name, InsuranceRenewal_Car_Model:@vehicle_model, InsuranceRenewal_Car_RegistrationNumber:insurance.registration_number, InsuranceRenewal_Customer_Address:insurance.address, InsuranceRenewal_Customer_Number:insurance.mobile, InsuranceRenewal_Customer_Email:insurance.email, InsuranceRenewal_Policy_Number:insurance.policy_number, InsuranceRenewal_Policy_Company:insurance.insurance_company, vehicle_year:insurance.purchase_date.strftime("%Y"), InsuranceRenewal_Policy_ExpiryDate:insurance.expiry_date, day:ex_date.strftime("%d").to_i.ordinalize, month:ex_date.strftime("%B"), year:ex_date.strftime("%Y"), weekday:ex_date.strftime("%A"), vehicle_kms:insurance.kms }
	@subject = @n_template.title  % { InsuranceRenewal_Customer_Name:insurance.name, InsuranceRenewal_Car_Model:@vehicle_model, InsuranceRenewal_Car_RegistrationNumber:insurance.registration_number, InsuranceRenewal_Customer_Address:insurance.address, InsuranceRenewal_Customer_Number:insurance.mobile, InsuranceRenewal_Customer_Email:insurance.email, InsuranceRenewal_Policy_Number:insurance.policy_number, InsuranceRenewal_Policy_Company:insurance.insurance_company, vehicle_year:insurance.purchase_date.strftime("%Y"), InsuranceRenewal_Policy_ExpiryDate:insurance.expiry_date, day:ex_date.strftime("%d").to_i.ordinalize, month:ex_date.strftime("%B"), year:ex_date.strftime("%Y"), weekday:ex_date.strftime("%A"), vehicle_kms:insurance.kms }
	mail :to => @mail_list.email, :subject => @subject
end

def insurance_renewal_confirm(insurance)
	vehicle_name = insurance.bike
	@n_template = EmailNotificationTemplate.find_by_category("Insurance renewal mail-user")
	ex_date = Date.parse(insurance.expiry_date)
	if vehicle_name == insurance.bike.to_i.to_s
		@vehicle_model = MyBike.find_by_id(insurance.bike).try(:bike) || 'N/A'
	else
		@vehicle_model = insurance.bike
	end

	@insurance_request_user = @n_template.content % { InsuranceRenewal_Customer_Name:insurance.name, InsuranceRenewal_Car_Model:@vehicle_model, InsuranceRenewal_Car_RegistrationNumber:insurance.registration_number, InsuranceRenewal_Customer_Address:insurance.address, InsuranceRenewal_Customer_Number:insurance.mobile, InsuranceRenewal_Customer_Email:insurance.email, InsuranceRenewal_Policy_Number:insurance.policy_number, InsuranceRenewal_Policy_Company:insurance.insurance_company, vehicle_year:insurance.purchase_date.strftime("%Y"), InsuranceRenewal_Policy_ExpiryDate:insurance.expiry_date, day:ex_date.strftime("%d").to_i.ordinalize, month:ex_date.strftime("%B"), year:ex_date.strftime("%Y"), weekday:ex_date.strftime("%A"), vehicle_kms:insurance.kms }
	@subject = @n_template.title  % { InsuranceRenewal_Customer_Name:insurance.name, InsuranceRenewal_Car_Model:@vehicle_model, InsuranceRenewal_Car_RegistrationNumber:insurance.registration_number, InsuranceRenewal_Customer_Address:insurance.address, InsuranceRenewal_Customer_Number:insurance.mobile, InsuranceRenewal_Customer_Email:insurance.email, InsuranceRenewal_Policy_Number:insurance.policy_number, InsuranceRenewal_Policy_Company:insurance.insurance_company, vehicle_year:insurance.purchase_date.strftime("%Y"), InsuranceRenewal_Policy_ExpiryDate:insurance.expiry_date, day:ex_date.strftime("%d").to_i.ordinalize, month:ex_date.strftime("%B"), year:ex_date.strftime("%Y"), weekday:ex_date.strftime("%A"), vehicle_kms:insurance.kms }
	mail :to => insurance.email, :subject => @subject
end

#price email for user
def send_price_document(params)
	variant = Varient.find_by_id(params[:id])
	if params[:name].present?
		user_name = params[:name]
	else
		user_name = params[:email] || nil
	end

	bike = variant.bike
	variant_price = variant.pricings.joins(:price_field)
    #pricings.joins(:price_field).where('price_fields.name like ?', '%nsu%').first.value TCS
    price_ex = variant_price.where(price_fields: {name: "Ex Showroom Price"}).first.value
    ex_basic_price = price_comma_separator(price_ex)
    ltt_charge = variant_price.where(price_fields: {name: "LTT Charges & RTO"}).first.value
    road_llt_charge = price_comma_separator(ltt_charge)
    insurance = variant_price.where(price_fields: {name: "Insurance"}).first.value
    insurence_one_year = price_comma_separator(insurance)
    bike_price = variant_price.where(price_fields: {name: "On Road Price"}).first.value
    on_road_price = price_comma_separator(bike_price)

    @n_template = EmailNotificationTemplate.find_by_category('Price email template')
    subject = @n_template.title
    @content = @n_template.content % { customer_name: user_name, variant_name: variant.varient_name, bike_name: variant.bike.name, ex_showroom_price: ex_basic_price, ltt_charges: road_llt_charge, insurance_year: insurence_one_year, on_road_price: on_road_price, bike_image: bike.default_bike_image.image_url } 
    mail :to => params[:email], :subject => subject
end 

#email price for dealer
def send_price_document_dealer(user, params, price_req)
	variant = Varient.find_by_id(params[:id])
	if user
		user_name = user.try(:profile).try(:full_name)
	else
		user_name = params[:email] || nil
	end	
	@mail_list = @@setmail.find_by_category("Price enquiry")
    @n_template = EmailNotificationTemplate.find_by_category('admin_price_enquiries')
    subject = @n_template.title % { PriceQuote_Customer_Name: price_req.name }
    @content = @n_template.content % { PriceQuote_Customer_Name: price_req.name, price_quote_email: price_req.email, price_quote_phone: price_req.mobile,price_quote_varient: variant.varient_name, price_quote_model: variant.bike.name ,price_quote_DateTime: price_req.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M %p') } 
    mail :to => @mail_list.email, :subject => subject
end 

def price_comma_separator(price)
		as = price.size
		case as
		when 4
			 price.insert(1, ",")
		when 5
			price.insert(2, ",")
		when 6
			 price.insert(1, ",").insert(4, ",")
		when 7
			 price.insert(2, ",").insert(5, ",")
		else
			price
		end
		return price
end

#for sending emi data email
def send_emi_price(params, user)
	if user
		user_name = user.try(:profile).try(:full_name)
	else
		user_name = nil
	end
	bike_image = Bike.find_by_name(params[:bike_name]).default_bike_image.try(:image_url)
	email = params[:email]
    @n_template = EmailNotificationTemplate.find_by_category('EMI Email Template')
    subject = @n_template.title
    @content = @n_template.content % { bike_name: params[:bike_name], variant_name: params[:variant_name], doc_charges: params[:charges], rate_interest: params[:interest], tenure: params[:tenure], down_payment: params[:downpay], loan_amount: params[:loan],  on_road_price: params[:onroadprice], total_amount: params[:emivalu], customer_name: user_name, bike_image: bike_image } 
    
    mail :to => email, :subject => subject
end

def used_vehicle_enquiry_confirm(used_vehicle_enquiry, customer_mail_template)
	@n_template = EmailNotificationTemplate.find_by_category(customer_mail_template)
	@enquiry_confirm_user = @n_template.content % { customer_name:used_vehicle_enquiry.name, customer_email:used_vehicle_enquiry.email, customer_address:used_vehicle_enquiry.address, customer_number:used_vehicle_enquiry.mobile, dealer_name:used_vehicle_enquiry.dealer_location, car:used_vehicle_enquiry.model, vehicle_year:used_vehicle_enquiry.manufacture_year, vehicle_price:used_vehicle_enquiry.price, content:used_vehicle_enquiry.comment, ContactUs_Comment:used_vehicle_enquiry.comment, car_kms:used_vehicle_enquiry.kms, registration_number:used_vehicle_enquiry.registration_number, dealer_number:used_vehicle_enquiry.dealer_number }
	
	@subject = @n_template.title % { customer_name:used_vehicle_enquiry.name, customer_email:used_vehicle_enquiry.email, customer_address:used_vehicle_enquiry.address, customer_number:used_vehicle_enquiry.mobile, dealer_name:used_vehicle_enquiry.dealer_location, car:used_vehicle_enquiry.model, vehicle_year:used_vehicle_enquiry.manufacture_year, vehicle_price:used_vehicle_enquiry.price, content:used_vehicle_enquiry.comment, ContactUs_Comment:used_vehicle_enquiry.comment, car_kms:used_vehicle_enquiry.kms, registration_number:used_vehicle_enquiry.registration_number, dealer_number:used_vehicle_enquiry.dealer_number }
	mail :to => used_vehicle_enquiry.email, :subject => @subject
end

def used_vehicle_enquiry(used_vehicle_enquiry, dealer_mail_template)
	@mail_list = @@setmail.find_by_category("Used Vehicle Enquiry")
	@n_template = EmailNotificationTemplate.find_by_category(dealer_mail_template)
	@enquiry_confirm_dealer = @n_template.content % { customer_name:used_vehicle_enquiry.name, customer_email:used_vehicle_enquiry.email, customer_address:used_vehicle_enquiry.address, customer_number:used_vehicle_enquiry.mobile, dealer_name:used_vehicle_enquiry.dealer_location, car:used_vehicle_enquiry.model, vehicle_year:used_vehicle_enquiry.manufacture_year, vehicle_price:used_vehicle_enquiry.price, content:used_vehicle_enquiry.comment, ContactUs_Comment:used_vehicle_enquiry.comment, car_kms:used_vehicle_enquiry.kms, registration_number:used_vehicle_enquiry.registration_number, dealer_number:used_vehicle_enquiry.dealer_number }
	@subject = @n_template.title % { customer_name:used_vehicle_enquiry.name, customer_email:used_vehicle_enquiry.email, customer_address:used_vehicle_enquiry.address, customer_number:used_vehicle_enquiry.mobile, dealer_name:used_vehicle_enquiry.dealer_location, car:used_vehicle_enquiry.model, vehicle_year:used_vehicle_enquiry.manufacture_year, vehicle_price:used_vehicle_enquiry.price, content:used_vehicle_enquiry.comment, ContactUs_Comment:used_vehicle_enquiry.comment, car_kms:used_vehicle_enquiry.kms, registration_number:used_vehicle_enquiry.registration_number, dealer_number:used_vehicle_enquiry.dealer_number }
	mail :to => @mail_list.email, :subject => @subject
end

#email for testmonial creation to admin
def nofity_testmonial_to_dealer(testmonial)
	@n_template = EmailNotificationTemplate.find_by_category("Testimonial")
	@mail_list = @@setmail.find_by_category("Testimonial")
	@testmonial_notify = @n_template.content % { Name: testmonial.name, Email: testmonial.email, Phone: testmonial.mobile, Testimonial: testmonial.description }

	mail :to => @mail_list.email, :subject => @n_template.title 
end


def send_notification_mail(user, notification_type)
	@notification_template = NotificationTemplate.find_by_category(notification_type)
	mail :to => user.email, :subject => @notification_template.try(:title), :body =>"this is the body"
end

def notification_mail_for_ride(user, ride, email_template)
	template = EmailNotificationTemplate.find_by_category(email_template)
	@ride_content = template.content % {Ride_Customer_Name: user.try(:profile).try(:full_name), Ride_Final_Destination: ride.destination_location, Ride_date: ride.ride_date, coordinator_name: ride.coordinator_name, coordinator_mobile: ride.coordinator_mobile}
	ride_title = template.title % {Ride_date: ride.ride_date}

	dt = calculate_ical_time(ride.ride_date, ride.assembly_time[0].to_time)
	cal = Icalendar::Calendar.new
	cal.event do |e|
		e.dtstart = Icalendar::Values::DateTime.new dt
		e.dtend   = Icalendar::Values::DateTime.new dt + 1.hour#testride.ride_time + 1.hour
		e.summary     = "Anant Bajaj"
		e.description = "Ride with Anant Bajaj"
		e.ip_class    = "PRIVATE"
		e.alarm do |a|
			a.action        = "AUDIO"
			a.trigger       = "-PT60M"
			a.append_attach "Ride request with Anant Bajaj"
		end
	end
	attachments['event.ics'] = cal.to_ical

	mail :to => user.email, :subject => ride_title
end

def notification_mail_for_event(user, event, email_template)
	template = EmailNotificationTemplate.find_by_category(email_template)
	@event_content = template.content % {Event_Customer_Name: user.try(:profile).try(:full_name), Event_Final_Destination: event.location, Event_date: event.event_date, coordinator_name: event.coordinator_name, coordinator_mobile: event.coordinator_mobile}
	event_title = template.title % {Event_date: event.event_date}


	dt = calculate_ical_time(event.event_date, event.event_time)
	cal = Icalendar::Calendar.new
	cal.event do |e|
		e.dtstart = Icalendar::Values::DateTime.new dt
		e.dtend   = Icalendar::Values::DateTime.new dt + 1.hour#testride.ride_time + 1.hour
		e.summary     = "Anant Bajaj"
		e.description = "Event with Anant Bajaj"
		e.ip_class    = "PRIVATE"
		e.alarm do |a|
			a.action        = "AUDIO"
			a.trigger       = "-PT60M"
			a.append_attach "Event request with Anant Bajaj"
		end
	end
	attachments['event.ics'] = cal.to_ical

	mail :to => user.email, :subject => event_title
end

def feedback(feedback)
	@feedback = feedback
	if @feedback.feedback_type == "Service"
	    @mail_list = @@setmail.where(category: "Feedback Service").first
	else
	    @mail_list = @@setmail.where(category: "Feedback Sales").first
	end
    #location: feedback.dealer_location
	#@mail_list = @@setmail.find_by_category("Feedback")
	@n_template = EmailNotificationTemplate.find_by_category("Feedback mail-dealer")
	@feedback_confirm_dealer = @n_template.content % { Feedback_Customer_Name:feedback.name, Feedback_Customer_Number:feedback.mobile, Feedback_Customer_Email:feedback.email, Feedback_Title:feedback.feedback_type, Feedback_Description:feedback.comment, Feedback_rating:feedback.rating, dealer_location:feedback.dealer_location }
	@subject = @n_template.title % { Feedback_Customer_Name:feedback.name, Feedback_Customer_Number:feedback.mobile, Feedback_Customer_Email:feedback.email, Feedback_Title:feedback.feedback_type, Feedback_Description:feedback.comment }
	mail :to => @mail_list.email, :subject => @subject
end

def sell_bike(sell_bike, dealer_mail_template)
	@mail_list = @@setmail.find_by_category("Sell Bike")
	user = User.find_by_id(sell_bike.user_id)
    sell_bike.make_coompany.present? ? make_name = sell_bike.make_coompany : make_name = sell_bike.used_bike_model.name
	@n_template = EmailNotificationTemplate.find_by_category(dealer_mail_template)

	@sell_bike_dealer = @n_template.content % { customer_name:user.try(:profile).try(:full_name), customer_email:user.email, vehicle_type:sell_bike.bike_type, customer_phone:user.try(:profile).try(:mobile), vehicle_make: make_name, vehicle_year:sell_bike.manufacture_year, vehicle_quotedPrice:sell_bike.price, vehicle_colour: sell_bike.color, vehicle_kms: sell_bike.kms, vehicle_registrationNo: sell_bike.registration_number, vehicle_gears: sell_bike.gear, vehicle_model: sell_bike.model, excahnge_bike: sell_bike.exchange }
	@subject = @n_template.title % { customer_name:user.try(:profile).try(:full_name), customer_email:user.email, vehicle_type:sell_bike.bike_type, customer_phone:user.try(:profile).try(:mobile), vehicle_make: make_name, vehicle_year:sell_bike.manufacture_year, vehicle_quotedPrice:sell_bike.price, vehicle_colour: sell_bike.color, vehicle_kms: sell_bike.kms, vehicle_registrationNo: sell_bike.registration_number, vehicle_gears: sell_bike.gear, vehicle_model: sell_bike.model, excahnge_bike: sell_bike.exchange }

	mail :to => @mail_list.email, :subject => @subject
end

def sell_bike_confirm(sell_bike, customer_mail_template)
	@n_template = EmailNotificationTemplate.find_by_category(customer_mail_template)
	sell_bike.make_coompany.present? ? make_name = sell_bike.make_coompany : make_name = sell_bike.used_bike_model.name
	user = User.find_by_id(sell_bike.user_id)
	@sell_bike_user = @n_template.content % { customer_name:user.try(:profile).try(:full_name), customer_email:user.email, vehicle_type:sell_bike.bike_type, customer_phone:user.try(:profile).try(:mobile), vehicle_make: make_name, vehicle_year:sell_bike.manufacture_year, vehicle_quotedPrice:sell_bike.price, vehicle_colour: sell_bike.color, vehicle_kms: sell_bike.kms, vehicle_registrationNo: sell_bike.registration_number, vehicle_gears: sell_bike.gear, vehicle_model: sell_bike.model, excahnge_bike: sell_bike.exchange }
	@subject = @n_template.title % { customer_name:user.try(:profile).try(:full_name), customer_email:user.email, vehicle_type:sell_bike.bike_type, customer_phone:user.try(:profile).try(:mobile), vehicle_make: make_name, vehicle_year:sell_bike.manufacture_year, vehicle_quotedPrice:sell_bike.price, vehicle_colour: sell_bike.color, vehicle_kms: sell_bike.kms, vehicle_registrationNo: sell_bike.registration_number, vehicle_gears: sell_bike.gear, vehicle_model: sell_bike.model, excahnge_bike: sell_bike.exchange }

	mail :to => user.email, :subject => @subject
end

#for payment changes sending emails
def payment_mail(payment, template, category)
	if category == 'User'
		@mail_list = payment.user.try(:email) 
	else
		mail_list = @@setmail.where(category: "Payment", location: payment.dealer.try(:dealer_name)).first 
		#mail_list_email = mail_list.map { |f| f if f.mail_type.include?(payment.entity_type) }.compact.last
		@mail_list = mail_list.try(:email)
	end	

	@n_template = EmailNotificationTemplate.find_by_category(template)
	user = payment.user
	name = user.try(:profile).try(:full_name)
	email = user.email
	phone = user.try(:profile).try(:mobile) || payment.phone
	amount = payment.amount || 'N/A'	
	entity = payment.try(:entity_type) || 'N/A'
	vehicle = payment.vehicle_name || 'N/A'
	regn = MyBike.find_by_id(payment.try(:bike_id)).try(:registration_number) || ''
	location = payment.merchant.try(:location) || 'N/A' 
	pay_type = payment.merchant.try(:merchat_type) || 'N/A' 
	dealer_name = payment.dealer.try(:dealer_name) || ''

    if payment.image.present?
	  doc_upload = "#{Rails.root}/public/" + payment.image.url
 	  attachments["#{payment.image.url.split('/').last}"] = File.read(doc_upload)
 	end
 	  	
	@payment_confirm_dealer = @n_template.content % { Payment_Customer_Name:name, User_Mail:email, Payment_Amount:amount, Payment_For:entity, User_Model:vehicle, Registration_No:regn , id: payment.id, Payment_Type:pay_type, Payment_Transaction_Id: payment.mihpayid, Payment_Date:payment.created_at.in_time_zone('Chennai').strftime('%d-%m-%Y %l:%M %p'), User_Phone: phone, Payment_Refund_Amount:payment.amount, payment_dealer_name: dealer_name, person_booking: payment.booking_person_name, mode_payment: payment.payment_mode }
	
	@subject = @n_template.title % { Payment_Customer_Name:payment.user.try(:profile).try(:full_name) }

	mail :to => @mail_list, :subject => @subject
end

#payment failed admin email
def payment_failed_status(payment)
	@n_template = EmailNotificationTemplate.find_by_category("Payment_failed")
	set_mail = @@setmail.where(dealer_brand: payment.dealer_brand)
	@mail_list = set_mail.find_by_category("Payment Failed")
	vehicle = payment.vehicle_name || 'N/A'

	@testmonial_notify = @n_template.content % { amount:amount, payment_for:entity, vehicle_name: vehicle, location: payment.merchant.try(:location), transaction_id: payment.mihpayid, date: payment.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M %p') }
	@subject = @n_template.title

    mail :to => @mail_list, :subject => @subject
end

#calcen refund email
def resend_cancel_email(payment, template)
	regn = MyBike.find_by_id(payment.try(:bike_id)).try(:registration_number) || ''
	help_line_num = "7676712255"
	@n_template = EmailNotificationTemplate.find_by_category(template)
	@content = @n_template.content % {username: payment.user.try(:profile).try(:full_name), user_email: payment.user.email, transaction_id: payment.txn_id, amount: payment.amount, payment_for: payment.try(:entity_type), User_Model: payment.vehicle_name, reg_no: regn, payment_helpline: help_line_num}
	title = @n_template.title % { Welcome_Customer_Name: payment.user.try(:profile).try(:full_name), Welcome_Customer_Email: payment.user.email }

	mail :to => payment.user.email, :subject => title
end

def contact_us(enquiry)
	@mail_list = @@setmail.where(category: "Enquiry", location: enquiry.try(:dealer_location) ).first || @@setmail.where(category: "Enquiry").first

	#@mail_list = @@setmail.find_by_category("Enquiry")
	@showroom = @@dealer.find_by_dealer_name(enquiry.try(:dealer_location) )

	@n_template = EmailNotificationTemplate.find_by_category("Contact us mail-dealer")
	@enq_content = @n_template.content % {ContactUs_Customer_Name: enquiry.name, ContactUs_Customer_Number: enquiry.phone, ContactUs_Customer_Email: enquiry.email, ContactUs_Dealerership_Name: enquiry.try(:dealer_location), ContactUs_AreaOfEnquiry: enquiry.category, ContactUs_Comment: enquiry.message, ContactUs_bike: enquiry.bike}
	enq_title = @n_template.title % {ContactUs_AreaOfEnquiry: enquiry.category}
	mail :to => @mail_list.email, :subject => enq_title
end	

def contact_us_user(enquiry)
	@mail_list = @@setmail.find_by_category("Enquiry")
	@showroom = @@dealer.find_by_dealer_name(I18n.t(enquiry.try(:dealer_location)) )

	@n_template = EmailNotificationTemplate.find_by_category("Contact us mail-user")
	@enq_content = @n_template.content % {ContactUs_Customer_Name: enquiry.name, ContactUs_Customer_Number: enquiry.phone, ContactUs_Customer_Email: enquiry.email, ContactUs_Dealerership_Name: enquiry.try(:dealer_location), ContactUs_AreaOfEnquiry: enquiry.category, ContactUs_Comment: enquiry.message, ContactUs_bike: enquiry.bike }
	enq_title = @n_template.title % {ContactUs_AreaOfEnquiry: enquiry.category}
	mail :to => enquiry.email, :subject => enq_title
end

def value_added_enquiry_dealer(enquiry)
	@mail_list = @@setmail.where(category: "Value Added Service").first
	@n_template = EmailNotificationTemplate.find_by_category("Value added service mail-dealer")
	@enq_content = @n_template.content % { customer_name: enquiry.name, customer_phone: enquiry.mobile, customer_email: enquiry.email, vehicle_model: enquiry.model, vehicle_purchase_date: enquiry.date_of_purchase, vehicle_registrationNo: enquiry.registration_number, vehicle_description: enquiry.description, vehicle_vas_name: enquiry.select_scheme }
	enq_title = @n_template.title % { customer_name: enquiry.name, customer_phone: enquiry.mobile, customer_email: enquiry.email, vehicle_model: enquiry.model, vehicle_purchase_date: enquiry.date_of_purchase, vehicle_registrationNo: enquiry.registration_number, vehicle_description: enquiry.description, vehicle_vas_name: enquiry.select_scheme }

	mail :to => @mail_list.email, :subject => enq_title
end	

def value_added_enquiry_user(enquiry)
	@n_template = EmailNotificationTemplate.find_by_category("Value added service mail-user")
	@enq_content = @n_template.content % { customer_name: enquiry.name, customer_phone: enquiry.mobile, customer_email: enquiry.email, vehicle_model: enquiry.model, vehicle_purchase_date: enquiry.date_of_purchase, vehicle_registrationNo: enquiry.registration_number, vehicle_description: enquiry.description, vehicle_vas_name: enquiry.select_scheme }
	enq_title = @n_template.title % { customer_name: enquiry.name, customer_phone: enquiry.mobile, customer_email: enquiry.email, vehicle_model: enquiry.model, vehicle_purchase_date: enquiry.date_of_purchase, vehicle_registrationNo: enquiry.registration_number, vehicle_description: enquiry.description, vehicle_vas_name: enquiry.select_scheme }

	mail :to => enquiry.email, :subject => enq_title
end

def welcome_user(user)
	@n_template = EmailNotificationTemplate.find_by_category("Welcome mail-user")
	@content = @n_template.content % {Welcome_Customer_Name:user.profile.full_name, Welcome_Customer_Email:user.email}
	title = @n_template.title
	mail :to => user.email, :subject => title
end

#genarate pdf for customer
def genartae_pdf_customer_email(params)
	@bikes = Bike.where(non_bajaj: false, visible: true)
	@user_email = params[:email]
	# @user_name = params[:name]
	# @mobile = params[:mobile]
	attachments["PriceList.pdf"] = WickedPdf.new.pdf_from_string(
     render_to_string(pdf: 'pricelist', template: 'uploads/generate_pdf.html.erb'))
	
	mail :to => @user_email, :subject => "Price List Request"
end

def dealer_pdf_email(params, price_chart)
	@mail_list = @@setmail.find_by_category("Price enquiry")
    @n_template = EmailNotificationTemplate.find_by_category('Price_List_Dealer')
    subject = @n_template.title % { PriceList_Customer_Name: price_chart.name, PriceList_email: price_chart.email, PriceList_phone: price_chart.mobile, PriceList_DateTime: price_chart.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M %p') }
    @content = @n_template.content % { PriceList_Customer_Name: price_chart.name, PriceList_email: price_chart.email, PriceList_phone: price_chart.mobile, PriceList_DateTime: price_chart.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M %p') } 
    
    mail :to => @mail_list.email, :subject => subject
end

def send_finance_document(email, family)
	doc = FinanceDocument.where('category = ? and family = ? ', 'Email Template', family).first
	subject = "Documents Required for Financing"
	@document = doc.document_list
	mail :to => email, :subject => subject
end	
def accessories_enquiry(user, enquiry, template)
	xm = generate_enquiry_table(enquiry)
	@mail_list = @@setmail.find_by_category("Wishlist")
	accessory = Accessory.where(id: enquiry.accessory_id).pluck(:title)
	@content = template.content % { customer_name:user.try(:profile).try(:full_name), customer_email:user.try(:email), phone_no:user.try(:profile).try(:mobile), address:user.try(:profile).try(:address), request_date:enquiry.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M'), request_time:enquiry.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M'), item_name:accessory, category_1:'N/A', category_2:'N/A', part_no:'0', accessories_data:xm }
	@title = template.title
	mail :to => @mail_list.email, :subject => @title
end

def accessories_enquiry_user(user, enquiry, template)
	xm = generate_enquiry_table(enquiry)
	@content = template.content % { customer_name:user.try(:profile).try(:full_name), customer_email:user.try(:email), phone_no:user.try(:profile).try(:mobile), address:user.try(:profile).try(:address), request_date:enquiry.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M'), request_time:enquiry.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M'), accessories_data:xm }
	@title = template.title
	mail :to => user.email, :subject => @title
end


def generate_enquiry_table(enquiry)
	accessory = Accessory.where(id: enquiry.accessory_id)
	data = [] 

	accessory.each do |a|
		hasher = {}
		hasher["Name"] =  a.title
		hasher["Price"] = a.try(:price) || 'N/A'
		hasher["Bike Name"] = a.try(:bike).try(:name) || 'N/A'
		data << hasher
	end


	#data = [{"col1"=>"v1", "col2"=>"v2"}, {"col1"=>"v3", "col2"=>"v4"}]
	xm = Builder::XmlMarkup.new(:indent => 2)
	xm.table  :border => '3px' do
		xm.tr { data[0].keys.each { |key| xm.th(key)}}
		data.each { |row| xm.tr { row.values.each { |value| xm.td(value)}}}
	end
	puts "#{xm}"
	return xm
end	

def calculate_ical_time(d, t)
	return DateTime.new(d.year, d.month, d.day, t.hour, t.min, t.sec, t.zone)
end

end
