class ServiceBooking < ApplicationRecord
	audited
	belongs_to :my_bike
	belongs_to :user

	def my_bike_name
		if MyBike.exists?(self.my_bike_id)
			MyBike.find_by_id(self.my_bike_id).try(:bike) || "N/A"	
		end
	end

	def user_name
		MyBike.find_by_id(self.my_bike_id).try(:user).try(:profile).try(:full_name) || nil
	end

	def user_mobile
		MyBike.find_by_id(self.my_bike_id).try(:user).try(:profile).try(:mobile) || nil	
	end

	def user_email
		MyBike.find_by_id(self.my_bike_id).try(:user).try(:email) || nil	
	end


	def service_created_at
		self.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end	

	def sevice_booking_notification(n_template, dealer_mail_template, customer_mail_template, params)
		template = NotificationTemplate.where(category: n_template).last
		if self.my_bike.present?
			user = self.my_bike.user
			noti = Notification.create(recipient: user, actor: user, action: 'Bookings', notifiable: self, notification_template: template)
	        logger.info "==========#{noti}============anil==========="
	        # mail to admin
	        UserMailer.delay.service_booking(self, dealer_mail_template, params)
	       # mail to confirm user
	       UserMailer.delay.service_request_confirm(self, customer_mail_template, params)
	   else
	    	 # mail to admin
	    	 UserMailer.delay.service_booking(self, dealer_mail_template, params)
	       # mail to confirm user
	       UserMailer.delay.service_request_confirm(self, customer_mail_template, params)
	   end
	end	
	
	def as_json(options={})
		super.as_json(options).merge({:my_bike_name => my_bike_name, :user_name => user_name, :user_mobile => user_mobile, :user_email => user_email, :created_at => service_created_at})
	end

end
