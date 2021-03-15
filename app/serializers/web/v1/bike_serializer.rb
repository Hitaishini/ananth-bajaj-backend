class Web::V1::BikeSerializer < ActiveModel::Serializer
	attributes :id, :name, :bike_image, :display_order, :pricing, :created_at, :updated_at, :visible ,:bike_type_name, :bike_brochure_url, :non_bajaj
	
	def bike_image
		object.default_bike_image.try(:image_url)
	end 

	def pricing
		object.try(:bike_price)
	end


	def created_at
		object.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end
	def updated_at
		object.updated_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end


end