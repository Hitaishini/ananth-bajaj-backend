class AboutUsPage < ApplicationRecord
	mount_base64_uploader :image, ImageUploader
end
