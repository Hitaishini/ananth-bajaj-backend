class UserEvent < ActiveRecord::Base
	belongs_to :event
	belongs_to :user

	def event_date
		self.event.event_date.strftime("%d-%m-%Y") if self.event.event_date
	end
	def event_time
		time = self.event.try(:event_time)
		time = time.strftime("%I:%M %p") if time
		time
	end
	def location
		self.event.try(:location)
	end
	def title
		self.event.try(:title)
	end
	def description
		self.event.try(:description)
	end
	
	def coordinator_name
		self.event.try(:coordinator_name)
	end
	
	def coordinator_number
		self.event.try(:coordinator_mobile)
	end

	def as_json(options={})
		if Event.exists?(self.event_id)
		  super(:only => [:id, :user_id, :event_id, :perticipate_event]).merge({:title => title, :event_date => event_date, :event_time => event_time, :assembly_location => location, :description => description, :coordinator_name => coordinator_name, :coordinator_mobile => coordinator_number})
		end
	end
end
