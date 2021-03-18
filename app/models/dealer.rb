class Dealer < ApplicationRecord
	audited
	serialize :dealer_type_id
	has_and_belongs_to_many :dealer_types
	has_many :dealer_contact_numbers
	has_many :used_bikes
	#serialize
	serialize :email
	serialize :image

	#mount_base64_uploader :image, ImageUploader, file_name: 'dealer'
	#call back
	#after_create :create_joint_table

	
	def dealer_tyep_name
		if DealerType.exists?([self.dealer_type_id].join(','))	
			if self.dealer_type_id.class == Array
			  @dealer_type_ids = self.dealer_type_id.sort
		     else
		     	@dealer_type_ids = [self.dealer_type_id].sort
		     end
			@dealer = []
			@dealer_type_ids.each do |id|
			 @dealer << DealerType.find(id).try(:dealer_type) if id 
		    end
		    @dealer
		else
			"null"
		end
	end

	def deler_contact_numbers
		self.dealer_contact_numbers.collect { |d| {name: d.dealer_contact_label.label_name, dealer_number: d.number} }
	end

	def service_created_at
		self.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M %p')
	end	

	def service_updated_at
		self.updated_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M %p')
	end	

	def as_json(options={})
		super.as_json(options).merge({ created_at: service_created_at, updated_at: service_updated_at, :dealer_type => dealer_tyep_name, dealer_numbers: deler_contact_numbers})
	end

	def create_joint_table
		@dealer_type = DealerType.find(self.dealer_type_id)
		self.dealer_types << @dealer_type
	end
end
