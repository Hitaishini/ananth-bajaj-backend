class DealerType < ApplicationRecord
	audited
	has_and_belongs_to_many :dealers

	def dealer_created_at
		self.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end	

	def dealer_updated_at
		self.updated_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end

	def as_json(options={})
		super.as_json(options).merge({created_at: dealer_created_at, updated_at: dealer_updated_at})
	end
	
end
