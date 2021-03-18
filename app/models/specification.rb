class Specification < ApplicationRecord
	audited
	belongs_to :specification_type
	belongs_to :bike
	belongs_to :specification_name

	def specification_type
		SpecificationType.find_by_id(self.specification_type_id).try(:name)
	end

	def bike_type
		Bike.find_by_id(self.bike_id).try(:name)
	end

	def spe_name
		SpecificationName.find_by_id(self.specification_name_id).try(:name)
	end

	def service_created_at
		self.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end

	def tech_updated_at
		self.updated_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end


	def as_json(options={})
		super.as_json(options).merge({updated_at: tech_updated_at, :bike_name => bike_type, :specifications_type => specification_type, specifi_name: spe_name, :created_at => service_created_at })
	end

	def self.import(file)
		begin     
			CSV.foreach(file.path, headers: true, encoding:'iso-8859-1:utf-8') do |row|
				bikes = find_by_id(row["id"]) || new
				bikes.attributes = row.to_hash
				bikes.save!
			end
		rescue StandardError => e 
			raise "Error on row #{$.}====#{e.message}==="    
		end
		
	end

private

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["name","specification_type_id", "specification_name_id", "bike_id", "value"]
    end
  end

end
 