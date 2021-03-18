class InsuranceRenewal < ApplicationRecord
	audited
  belongs_to :my_bike

	def send_insurance_notification
			template = NotificationTemplate.where(category: I18n.t('Notification.insurance_renewal')).last
      user = User.find_by_email(self.email)
      if user
      	Notification.create(recipient: user, actor: user, action: 'Bookings', notifiable: self, notification_template: template)
      	UserMailer.delay.insurance_renewal(self)
     		UserMailer.delay.insurance_renewal_confirm(self)	
    	end
	end	


  def service_created_at
    self.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
  end 

  def service_updated_at
    self.updated_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
  end 

  def as_json(options={})
    super.as_json(options).merge({updated_at: service_updated_at, created_at: service_created_at })
  end
  
end
