class HogRegistration < ApplicationRecord
	belongs_to :user

	mount_base64_uploader :profile_image, ImageUploader, file_name: 'hog_registration'

end