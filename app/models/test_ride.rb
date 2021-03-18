class TestRide < ApplicationRecord
	audited
	belongs_to :user

	def test_ride_booking_notification(n_template, dealer_mail_template, customer_mail_template, params)
		logger.info "=======Test Booking Notification Error #{self.inspect}======"
		template = NotificationTemplate.where(category: n_template).last
	    Notification.create(recipient: self.user, actor: self.user, action: 'Bookings', notifiable: self, notification_template: template)
	    UserMailer.delay.test_ride_booking(self, dealer_mail_template, params)
	    UserMailer.delay.testride_request_confirm(self, customer_mail_template)
	end	


	def service_created_at
		self.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end	

	def as_json(options={})
		super.as_json(options).merge({created_at: service_created_at })
	end
	
end
