class ServiceSchedule < ApplicationRecord
	audited
	belongs_to :bike
	#validation
	validates_uniqueness_of :service_number, :scope => [:bike_id]

	def bike_name
		Bike.find(self.bike_id).name
	end
	def service_created_at
		self.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end
	def service_updated_at
		self.updated_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end	

	def as_json(options={})
		super.as_json(options).merge({:bike_name => bike_name, created_at: service_created_at, updated_at: service_updated_at })
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
      csv << ["service_number","bike_id", "months", "total_kms","service_type","range"]
    end
  end
	
end
