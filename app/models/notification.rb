class Notification < ActiveRecord::Base
	audited
# Associations
belongs_to :recipient, class_name: "User"
belongs_to :actor, class_name: "User"
belongs_to :notifiable, polymorphic: true
after_create :send_notification
belongs_to :notification_template
belongs_to :bulk_notification
	# @params user_id, notification_typo
	def send_notification(recipient = nil, action = nil)
		puts "============SEND NOTIFICATION=============="
		 logger.info "==========kumar=========#{@user.inspect}========"
		@user = self.recipient || recipient
		@notification_type = self.action || action 
		if self.notification_template.present?
			@notification_template = self.notification_template
		else
			@notification_template = self.bulk_notification
		end
		#self.update_attribute(:notification_template, @notification_template) unless self.notification_template_id
		if @user.present?
			 logger.info "==========notificatrion send with user=====#{@user.android_token}========"
			if @user.android_token.present? && @user.ios_token.present?
				android_notification 
				ios_notification
				increase_notification_count
			else
				if @user.android_token.present?
					android_notification 
					increase_notification_count
				end
				if @user.ios_token.present?
					ios_notification
					increase_notification_count
				end
			end
		end


		#UserMailer.send_notification_mail(@user, @notification_type).deliver
	end

	def self.proactive_insurance_reminder
		@set_rule = SetRule.where(category: 'Insurance renewal').first
		todays_date = Date.today
		template = NotificationTemplate.where(category: "Insurance renewal in-app reminder notification").last
		logger.info "===========#{I18n.t('Notification.insurance_renewal_reminder')}=====#{template.inspect}===="
		@set_rule.days.split(",").map { |s| s.to_i }.each do |day|
			reminder_date = todays_date + day
			MyBike.where(insurance_expiry_date:  reminder_date, status: 'Active').each do |mybike|
				Notification.create(recipient: mybike.user, actor: mybike.user, action: 'Bookings', notifiable: mybike, notification_template: template)
			end	
		end	
	end	

	def self.proactive_service_booking_reminder
		@set_rule = SetRule.where(category: 'Service booking').first
		todays_date = Date.today
		template = NotificationTemplate.where(category: "Re-active sevice reminder notification").last
		@set_rule.days.split(',').each do |day|
			reminder_date = todays_date + day.to_i
			ServiceBooking.where(service_date: reminder_date, status: 'Active').each do |service_booking|
				Notification.create(recipient: service_booking.my_bike.user, actor: service_booking.my_bike.user, action: 'Bookings', notifiable: service_booking, notification_template: template)
			end	
		end	
	end

	def self.proactive_test_drive_reminder
		@set_rule = SetRule.where(category: 'Re-active test drive reminders').first
		todays_date = Date.today
		template = NotificationTemplate.where(category: "Re-active test drive reminder notification").last
		@set_rule.days.split(",").map { |s| s.to_i }.each do |day|
			reminder_date = todays_date + day
			TestRide.where(ride_date:  reminder_date, status: 'Active').each do |test_ride|
				Notification.create(recipient: test_ride.user, actor: test_ride.user, action: 'Bookings', notifiable: test_ride, notification_template: template)
			end	
		end	
	end

	# based on KM and service interval months
	def self.proactive_service_interval
		@set_rule = SetRule.where(category: 'Service Interval').first
		@set_rule1 = SetRule.where(category: 'Service booking').first
		todays_date = Date.today
		bikes = []
		MyBike.where(status: 'Active').each do |mybike|
			if mybike.km_exceeds_for_months
				bikes << mybike.id
				template = NotificationTemplate.where(category: I18n.t('Notification.kms_exceeds')).last
				n = Notification.new(recipient: mybike.user, actor: mybike.user, notification_template: template, notifiable: mybike, action: 'Bookings')
				n.save!
			end
		end

		remaining_bikes = MyBike.where.not(id: bikes).where(status: 'Active')

		@set_rule.days.split(",").map { |s| s.to_i }.each do |day|
			remaining_bikes = MyBike.where.not(id: bikes).where(status: 'Active')
			@set_rule1.days.split(",").map { |s| s.to_i }.each do |day1|
				reminder_date = (todays_date - day.months) + day1
				remaining_bikes.each do |mybike|
					if(mybike.purchase_date == reminder_date)
						bikes << mybike.id
						Rails.cache.write("#{mybike.id}", mybike.purchase_date + day.months)
						template = NotificationTemplate.where(category: I18n.t('Notification.service_reminder')).last
						n = Notification.new(recipient: mybike.user, actor: mybike.user, notification_template: template, notifiable: mybike, action: 'Bookings')
						n.save!
					end	
				end
			end	
		end	
	end

	def self.proactive_birthday_anniversory_notification
		day  = Date.today.day
		month = Date.today.month
		@profiles = Profile.where('extract(month from dob) = ? and extract(day from dob) = ?', month, day)
		@profiles.each do |profile|
			Notification.create(recipient: profile.user, actor: profile.user, action: I18n.t('Notification.birthday'), notifiable: profile)
		end	
	end	

	def self.send_bulk_notification(users, action, template)
		Notification.skip_callback(:create, :after, :send_notification) 
		@parent  = Notification.create(action: action, bulk_notification: template)
		Notification.set_callback(:create, :after, :send_notification)
		
		action1 = case action
		when 'Insurance Renewal'
			'Bookings'
		when 'New Car'
			'Offer'
		when 'Service'
			'Bookings'
		when 'Tips'
			'Tips'
		when 'Test Drive'
			'Bookings'
		else
			'Offer'
		end

		if users
			User.where(id: users).each do |user|
				Notification.create(recipient: user, actor: user, action: action1, notifiable: user, parent_id: @parent.id, bulk_notification: template)
			end	
		else	
			User.find_each do |user|
				Notification.create(recipient: user, actor: user, action: action1, notifiable: user, parent_id: @parent.id, bulk_notification: template)
			end	
		end	
	end

	def self.get_action_by_category category
		case category
		when 'Insurance Renewal'
			'Bookings'
		when 'New Car'
			'Offer'
		when 'Service'
			'Bookings'
		when 'Test Drive'
			'Bookings'
		when 'Tips'
			'Tips'
		else
			'Offer'
		end
	end				

	
	private

	def android_notification
		logger.info "===========Sending Android Notificaion Started======="
		n = Rpush::Gcm::Notification.new
		n.app = Rpush::Gcm::App.find_by_name("Silicon-Honda")
		n.registration_ids = [@user.android_token]
		content, title  = @notification_template.fill_keywords(self.notifiable, self.recipient)
		logger.info "title=========#{title}"
		logger.info "content=========#{content}"
		self.update_attributes(title: title.to_s, content: content.to_s)
		if @notification_template.has_attribute?("image")
			logger.info "===Sending image"
			if @notification_template.try(:image).try(:url)
				logger.info "========#{@notification_template.image.url}"
				image = "https://anant-bajaj-dev.myridz.com" + @notification_template.image.url
				n.data =  {"data": {"title": title,"message": "Tap here to view details","style": "picture","picture": image,"summaryText": "Tap here to view details", id: self.id}}
			else
				logger.info "Without image"
				n.data = {"data":{ title: title, message: "Tap here to view details", time_stamp: self.created_at , type: self.notifiable.class.to_s, id: self.id}}
			end
			
		else	
			n.data = { title: title, message: "Tap here to view details", time_stamp: self.created_at, type: self.notifiable.class.to_s, id: self.id }
		end
		n.priority = 'high'        # Optional, can be either 'normal' or 'high'
		n.content_available = true # Optional
		n.notification = { }
		n.save! if @user.notification_enabled?(self.action)
		logger.info "===========Sending Android Notificaion Completed======="	

	end	


	def ios_notification
		logger.info "===========Sending ios Notificaion Started======="
		n = Rpush::Apns::Notification.new
		n.app = Rpush::Apns::App.find_by_name("Silicon-Honda")

			 	n.device_token = @user.ios_token # 64-character hex string
			 	n.alert = "You have a notification"
			 	content, title  = @notification_template.fill_keywords(self.notifiable, self.recipient)
			 	self.update_attributes(title: title.to_s, content: content.to_s)
			 	logger.info "============#{content.inspect}===#{title.inspect}"
			    #n.data = { data: { title: title, message: "Tap here to view details" } }


			    if  @notification_template.has_attribute?("image")
			    	logger.info "===Sending image"
			    	if @notification_template.try(:image).try(:url)
			    		logger.info "========#{@notification_template.image.url}"
			    		image = "https://anant-bajaj-dev.myridz.com" + @notification_template.image.url
			    		n.data =  {"data": {"title": title,"message": "Tap here to view details","style": "picture","picture": image,"summaryText": "Tap here to view details", id: self.id}}
			    	else
			    		logger.info "Without image"
			    		n.data = {  title: title, message: "Tap here to view details", time_stamp: self.created_at , type: self.notifiable.class.to_s, id: self.id}
			    	end
			    else	
			    	n.data = {  title: title, message: "Tap here to view details", time_stamp: self.created_at, type: self.notifiable.class.to_s, id: self.id } 
			    end
			    logger.info "==#{n.app.inspect}=========Sending ios Notificaion completed======="	 	
			    a = n.save! if @user.notification_enabled?(self.action)
			    logger.info "========+#{a.inspect}+======="
	end		

			def increase_notification_count
				NotificationCount.where(user: @user).first.add_notification_count(self.action) if NotificationCount.where(user: @user).first
			end	

end
