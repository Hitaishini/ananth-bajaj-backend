class Career < ActiveRecord::Base
	belongs_to :job
	mount_base64_uploader :cv_file, CareerUploader
end
