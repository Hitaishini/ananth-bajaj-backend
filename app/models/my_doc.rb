class MyDoc < ActiveRecord::Base
	belongs_to :user

	#mount_base64_uploader :image, ImageUploader, file_name: 'my_doc'
	mount_uploader :image, MyDocUploader
end
