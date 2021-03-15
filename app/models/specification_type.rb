class SpecificationType < ActiveRecord::Base
	audited
	has_many :specifications
	has_many :specification_names

	def service_created_at
		self.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end	

	def as_json(options={})
		super.as_json(options).merge({created_at: service_created_at })
	end
end
