class Merchant < ApplicationRecord
	has_many :payments
	#serialization
	serialize :payment_for
	serialize :dealer_id

	def merchant_created_at
		self.created_at.in_time_zone('Chennai').strftime('%d-%m-%Y %l:%M %p')
	end
	def merchant_updated_at
		self.updated_at.in_time_zone('Chennai').strftime('%d-%m-%Y %l:%M %p')
	end	

	def merchant_name
		Dealer.where(id: self.dealer_id).map{|x| x.dealer_name }.flatten.compact
	end

	def as_json(options={})
		super.as_json(options).merge({ created_at: merchant_created_at, updated_at: merchant_updated_at ,merchant_name: merchant_name})
	end
end
