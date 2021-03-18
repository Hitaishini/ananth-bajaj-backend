class WebBanner < ApplicationRecord
	audited
	mount_base64_uploader :image, WebBannerUploader
	belongs_to :bike

	def service_created_at
		self.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M %p')
	end	

	def service_updated_at
		self.updated_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M %p')
	end	

	def bike_type_data
		self.try(:bike).try(:bike_type).try(:name)
	end



	def as_json(options={})
		super.as_json(options).merge({created_at: service_created_at, updated_at: service_updated_at ,bike_type_name: bike_type_data })
	end
end
