class UserRide < ApplicationRecord
	belongs_to :user
	belongs_to :ride

	def ride_route
		self.ride.try(:route)
	end

	def ride_date
		self.ride.ride_date.strftime("%d-%m-%Y") if self.ride.ride_date
	end

	def ride_distance
		self.ride.try(:distance)
	end

	def ride_location
		self.ride.try(:assembly_location)
	end

	def ride_destination_location
		self.ride.try(:destination_location)
	end

	def assembly_time
		self.ride.try(:assembly_time) || []
	end

	def title
		self.ride.try(:title)
	end

	def destination_time
		self.ride.try(:destination_time) || []
	end

	def check_points
		self.ride.try(:check_points) || []
	end

	def coordinator_name
		self.ride.try(:coordinator_name)
	end
	
	def coordinator_number
		self.ride.try(:coordinator_mobile)
	end

	def user_ride_notification(notification_template, email_template)
		template = NotificationTemplate.where(category: notification_template).last
    Notification.create(recipient: self.user, actor: current_user, action: 'Events', notifiable: self.ride, notification_template: template)
    UserMailer.delay.notification_mail_for_ride(self.user, self.ride, email_template)
	end	

	def as_json(options={})
		if Ride.exists?(self.ride_id)
		  super(:only => [:id, :user_id, :ride_id, :perticipate_ride]).merge({:title => title, :route => ride_route, :distance => ride_distance, :assembly_location => ride_location, :destination_location => ride_destination_location, :assembly_time => assembly_time, :destination_time => destination_time, :check_points => check_points, :ride_date => ride_date, :coordinator_name => coordinator_name, :coordinator_mobile => coordinator_number})
	    else
	    	super(:only => [:id, :user_id, :ride_id, :perticipate_ride])
	    end
	end
end
