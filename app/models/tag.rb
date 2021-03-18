class Tag < ApplicationRecord
	has_many :accessories, through: :accessory_tags
	has_many :accessory_tags
	belongs_to :accessory_category
	mount_base64_uploader :image, ImageUploader, file_name: 'tag'


	def accessory_cat
		self.accessory_category.try(:title)
	end	

	def tag_created_at
		self.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end	

	def tag_updated_at
		self.updated_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end


	def as_json(options={})
    super.as_json(options).merge({:accessory_category_name => accessory_cat, created_at: tag_created_at, updated_at: tag_updated_at})
  end
end
