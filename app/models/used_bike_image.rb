class UsedBikeImage < ActiveRecord::Base
	belongs_to :used_bike

  mount_base64_uploader :image, ImageUploader, file_name: 'used_bike_image'
end
