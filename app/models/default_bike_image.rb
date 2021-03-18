class DefaultBikeImage < ApplicationRecord
	audited
	belongs_to :bike
	has_many :my_bikes

	def bike_name
		Bike.find(self.bike_id).name
	end
	def service_created_at
		self.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end
	def service_updated_at
		self.updated_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end		


	def as_json(options={})
		super.as_json(options).merge({:bike_name => bike_name, created_at: service_created_at, updated_at: service_updated_at})
	end
end
