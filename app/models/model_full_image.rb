class ModelFullImage < ApplicationRecord
	belongs_to :bike
	
	#serialize
	serialize :image
	serialize :video_url


	def bike_name_value
		self.bike.try(:name)
	end

	def service_created_at
		self.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M %p')
	end

	def service_updated_at
		self.updated_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M %p')
	end	

	def as_json(options={})
		super.as_json(options).merge({ bike_name: bike_name_value, created_at: service_created_at, updated_at: service_updated_at})
	end

end
