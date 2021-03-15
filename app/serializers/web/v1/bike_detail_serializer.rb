class Web::V1::BikeDetailSerializer < ActiveModel::Serializer
	attributes :id, :name, :bike_brochure_url, :display_order, :bike_cc, :created_at, :updated_at, :visible ,:bike_price, :non_bajaj, :bike_type_id, :bike_type_name, :default_bike_data
	
	def created_at
		object.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end

	def updated_at
		object.updated_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end

	def bike_type_name
		self.bike_type.try(:name)
	end

	def default_bike_data
		self.default_bike_image
	end

end