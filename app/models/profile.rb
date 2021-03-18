class Profile < ApplicationRecord
	belongs_to :user

	mount_base64_uploader :profile_image, ImageUploader, file_name: 'profile'

	def service_created_at
		self.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end	

	def as_json(options={})
		super.as_json(options).merge({created_at: service_created_at })
	end
end
