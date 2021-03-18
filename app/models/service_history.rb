class ServiceHistory < ApplicationRecord
	audited
	belongs_to :my_bike
	#mount_base64_uploader :bill_image, ImageUploader, file_name: 'service_history'
	mount_uploader :bill_image, ImageUploader, file_name: 'service_history'

	def self.import(file)
		begin     
			CSV.foreach(file.path,  headers: true, encoding:'iso-8859-1:utf-8') do |row|
				service_history = find_by_id(row["id"]) || new
				service_history.attributes = row.to_hash
				service_history.save!
			end
		rescue StandardError => e 
			raise "Error on row #{$.}====#{e.message}==="    
		end	
	end

	def service_created_at
		self.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end
	def service_updated_at
		self.updated_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end		

	def as_json(options={})
		super.as_json(options).merge({ created_at: service_created_at, updated_at: service_updated_at })
	end



	def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["service_date","service_type", "kms", "total_cost","my_bike_id","document_name","file_type"]
    end
  end

end
