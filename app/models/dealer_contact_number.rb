class DealerContactNumber < ApplicationRecord
	audited
	belongs_to :dealer
	belongs_to :dealer_contact_label

	def dealer_label_name
      DealerContactLabel.find(self.dealer_contact_label_id).label_name
	end

	def dealer_name
      Dealer.find(self.dealer_id).dealer_name
	end


	def service_created_at
		self.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end
	def service_updated_at
		self.updated_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end		
	
	def as_json(options={})
		super.as_json(options).merge({:dealer_label_name => dealer_label_name, :dealer_name => dealer_name, :created_at => service_created_at, updated_at: service_updated_at })
	end
end
