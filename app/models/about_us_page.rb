class AboutUsPage < ActiveRecord::Base
	mount_base64_uploader :image, ImageUploader
end
