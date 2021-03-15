class WebDisplayCarImage < ActiveRecord::Base
	belongs_to :car


	def display_car_name
		self.car.try(:car_name)
	end	

	def as_json(options={})
		super.as_json(options).merge({car_name: display_car_name})
	end

end
