class AccessoryCategory < ActiveRecord::Base
	audited
	has_many :tags
	mount_base64_uploader :image, ImageUploader, file_name: 'accessory_category'

	def service_created_at
		self.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end	

	def acc_updated_at
		self.updated_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end

	def as_json(options={})
		super.as_json(options).merge({created_at: service_created_at, updated_at: acc_updated_at})
	end
	
end
