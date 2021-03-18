class WebCarGallery < ApplicationRecord
	belongs_to :car
	#serializer
	serialize :image_url
	serialize :diff_int_ext


	def gallery_car_name
		self.car.try(:car_name)
	end	

	def as_json(options={})
		super.as_json(options).merge({car_name: gallery_car_name})
	end
end
