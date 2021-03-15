class BikeColor < ActiveRecord::Base
	audited
	belongs_to :bike

	#mount_base64_uploader :image, ImageUploader, file_name: 'bike_color'

	def bike_type
		Bike.find_by_id(self.bike_id).name
	end
	def service_created_at
		self.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end
	def service_updated_at
		self.updated_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end		

	def as_json(options={})
		super.as_json(options).merge({ :bike_name => bike_type, created_at: service_created_at, updated_at: service_updated_at })
	end

	def self.import(file)
		begin     
			CSV.foreach(file.path, headers: true, encoding:'iso-8859-1:utf-8') do |row|
				bike_colors = find_by_id(row["id"]) || new
				bike_colors.attributes = row.to_hash
				bike_colors.save!
			end
		rescue StandardError => e 
			raise "Error on row #{$.}====#{e.message}==="    
		end
		
	end


	def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["label","color", "bike_id", "image"]
    end
  end

end

