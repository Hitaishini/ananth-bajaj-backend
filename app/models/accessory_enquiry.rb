class AccessoryEnquiry < ActiveRecord::Base
	serialize :accessory_id

	def send_notification(user) 
		template = NotificationTemplate.where(category: I18n.t('Notification.accessories')).last
		Notification.create(recipient: user, actor: user, action: 'Accessories', notifiable: self, notification_template: template)
	  # mail to admin
	  template = EmailNotificationTemplate.find_by_category("Wishlist Dealer")
	  UserMailer.delay.accessories_enquiry(user, self, template)
	  # mail to confirm user
	  template = EmailNotificationTemplate.find_by_category("Wishlist Customer")
	  UserMailer.delay.accessories_enquiry_user(user, self, template)
	end	

	def accessories_name
		accessory = Accessory.where(id: self.accessory_id).pluck(:title)
	end	

	def user_email
		if User.exists?(self.user_id)
		  User.find(self.user_id).try(:email)
		else
			"nil"
		end
	end	

	def user_name
		User.find_by_id(self.user_id).try(:profile).try(:full_name) || nil
	end
	def user_number
		User.find_by_id(self.user_id).try(:profile).try(:mobile) || nil
	end


   def created_at_format
	self.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
   end
   def updated_at_format
  	self.updated_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
  end

	def as_json(options={})
		super.as_json(options).merge({ created_at: created_at_format, updated_at: updated_at_format,accessories: accessories_name, user_email: user_email, user_name: user_name, user_phone_number: user_number})
	end
end
