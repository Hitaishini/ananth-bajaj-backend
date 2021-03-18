class Career < ApplicationRecord
	belongs_to :job
	mount_base64_uploader :cv_file, CareerUploader
end
