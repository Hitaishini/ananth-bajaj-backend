class ContactNumber < ActiveRecord::Base
	audited
	belongs_to :contact_type


	def contact_type_name
		ContactType.find_by_id(self.contact_type_id).try(:label) || "abc"
	end
	def service_created_at
		self.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end
	def service_updated_at
		self.updated_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end		

	
	def as_json(options={})
		super.as_json(options).merge({ :contact_type_name => contact_type_name, created_at: service_created_at, updated_at: service_updated_at })
	end
end
