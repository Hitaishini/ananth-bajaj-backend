class UsedBikeEnquiry < ActiveRecord::Base

	def used_car_enquiry_notification(noti_template, dealer_mail_template, customer_mail_template, params)
		user = User.find_by_email(self.email)
		if user
			template = NotificationTemplate.where(category: noti_template).last
			Notification.create(recipient: user, actor: user, action: 'Offer', notifiable: self, notification_template: template)
			UserMailer.delay.used_vehicle_enquiry(self, dealer_mail_template)
			UserMailer.delay.used_vehicle_enquiry_confirm(self, customer_mail_template)
		else
			UserMailer.delay.used_vehicle_enquiry(self, dealer_mail_template)
			UserMailer.delay.used_vehicle_enquiry_confirm(self, customer_mail_template)
		end
	end

end
