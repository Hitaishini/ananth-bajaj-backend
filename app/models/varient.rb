class Varient < ApplicationRecord
	audited
	belongs_to :bike
	has_many :key_features, :dependent => :destroy
	has_many :pricings, :dependent => :destroy
	has_many :price_fields, :through => :pricings
	has_many :key_feature_types, :through => :key_features

	def variant_bike_name
		self.bike.name if self.bike
	end

	def service_created_at
		self.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M %p')
	end	

	def service_updated_at
		self.updated_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M %p')
	end	

	def as_json(options={})
		super.as_json(options).merge({:bike_name => variant_bike_name, created_at: service_created_at, updated_at: service_updated_at})
	end



  def self.import(file)
    CSV.foreach(file.path, headers: true, encoding:'iso-8859-1:utf-8') do |row|
        @varient_data = row.to_hash
        @varient = find_by_id(row["ID"]) || new
        @varient.varient_name = @varient_data["varient_name"]
        @varient.fuel_type = @varient_data["fuel_type"].titleize
        @varient.transmission_type = @varient_data["transmission_type"].titleize
        @varient.bike_id = @varient_data["bike_id"]
        @varient.cc = @varient_data["cc"]
        @varient.gear = @varient_data["gear"]
        @varient.mileage = @varient_data["mileage"]
        @varient.visible = true
        @varient.save!
    end
end

  	def self.to_csv(options = {})
		CSV.generate(options) do |csv|
			csv << ["varient_name", "fuel_type", "transmission_type", "bike_id", "cc", "gear", "mileage"]
			end
	end


end
