class KeyFeature < ApplicationRecord
	audited
	belongs_to :bike
	belongs_to :key_feature_type
	belongs_to :varient
	#mount_base64_uploader :image, ImageUploader, file_name: 'key_feature'

	def key_feature_type
		KeyFeatureType.find_by_id(self.key_feature_type_id).try(:feature_type_name)
	end

	def bike_type
		Bike.find_by_id(self.bike_id).try(:name)
	end

	def service_created_at
		self.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end	

	def feature_updated_at
		self.updated_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end

	def as_json(options={})
		super.as_json(options).merge({ updated_at: feature_updated_at,:bike_name => bike_type, :key_feature_type => key_feature_type, :created_at => service_created_at })
	end

	def self.import(file)
		begin     
			CSV.foreach(file.path, headers: true, encoding:'iso-8859-1:utf-8') do |row|
				key_features = find_by_id(row["id"]) || new
				key_features.attributes = row.to_hash
				key_features.save!
			end
		rescue StandardError => e 
			raise "Error on row #{$.}====#{e.message}==="    
		end
		
	end

	def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["title","description", "image", "bike_id","key_feature_type_id","varient_id"]
    end
  end

end
   