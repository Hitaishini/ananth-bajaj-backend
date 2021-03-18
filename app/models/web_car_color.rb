class WebCarColor < ApplicationRecord
	belongs_to :car
	#serializer
	serialize :color_name
	serialize :s3_image_url
	serialize :s3_pallet_image_url


	def color_car_name
		self.car.try(:car_name)
	end	

	def as_json(options={})
		super.as_json(options).merge({car_name: color_car_name})
	end

end
