class Bike < ApplicationRecord
	audited
	belongs_to :bike_type
	has_one :default_bike_image, :dependent => :destroy
	has_many :varients, :dependent => :destroy
	has_many :specifications, :dependent => :destroy
	has_many :key_features, :dependent => :destroy
	has_many :pricings, :dependent => :destroy
	has_many :bike_colors, :dependent => :destroy
	has_many :galleries, :dependent => :destroy
	has_many :service_schedules, :dependent => :destroy
	#for accessories
	has_many :accessories, :dependent => :destroy
	#for 360 degree 
	has_many :model_full_images, :dependent => :destroy

	#vehicle faqs
	has_many :vehicle_faqs , :dependent => :destroy

	has_many :banners, :dependent => :destroy
	has_many :web_banners, :dependent => :destroy
	#serialize
	serialize :compare_vehicles

	#scope methods
	scope :gear, lambda { |gear| includes(:varients).where(varients: {gear: gear})}

	#for min and max of cc and price bvalues
	def self.min_max
		@bike = Bike.all
		@min_price = @bike.minimum(:bike_price)
		@max_price = @bike.maximum(:bike_price)
		@min_cc = @bike.minimum(:bike_cc)
		@max_cc = @bike.maximum(:bike_cc)
		@min_max = []
		@min_max << [ minimum_price: @min_price, maximum_price: @max_price, minimum_cc: @min_cc, maximum_cc: @max_cc ]
		@min_max = @min_max.flatten   
		return @min_max
	end



	def bike_type_name
		self.bike_type.try(:name)
	end

	def bike_image_url
		self.default_bike_image
	end

	def bike_specifications
		@specifications = []
		self.specifications.each do |specification|
			@specification_name = SpecificationType.find_by_id(specification.specification_type_id).try(:name)
			@specifications << Hash[@specification_name, specification]
		end
		@specifications.flat_map(&:entries).group_by(&:first).map{|k,v| Hash[specification_type: k, values: v.map(&:last)]}
	end

	def key_feature
		@key_features = []
		self.key_features.each do |key_feature|
			@key_feature_name = KeyFeatureType.find_by_id(key_feature.key_feature_type_id).try(:feature_type_name)
			@key_features << Hash[@key_feature_name, key_feature]
		end
		@key_features.flat_map(&:entries).group_by(&:first).map{|k,v| Hash[key_feature_type: k, values: v.map(&:last)]}
	end

	

	def pricing
		price_field_values = []
		self.varients.each do |variant|
			# variant.price_fields.each do |price_field|
			variant.price_fields.includes(:pricings).where.not(pricings: {value: ["0", nil, ""]}).each do |price_field|
				price_field_name = price_field.name
				price_field_values << { :varient => variant, :price_field_name => price_field_name, :price_field_values => price_field.pricings.where(varient_id: variant.id) }
			end
		end
		price_field_values
	end

	def bike_color
		self.bike_colors
	end

	def gallery
		self.galleries
	end

	#for varients
	def bike_varient_data
		self.varients.where(:visible => true) if self
	end

	def service_created_at
		self.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end
	def service_updated_at
		self.updated_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end

	#video url
	def bike_video_url
		self.model_full_images.collect { |f| f if f.video_url.present? } if self.model_full_images
	end

	def full_rotation_images
		self.model_full_images.collect { |f| f if f.image.present? } if self.model_full_images
	end

	def as_json(options={})
		super.as_json(options).merge({:bike_type_name => bike_type_name, :default_bike_data => bike_image_url, :specifications => bike_specifications, :key_features => key_feature, :price => pricing, :bike_colors => bike_color, :bike_gallery => gallery, :bike_varients => bike_varient_data, video_url: bike_video_url, model_full_images: full_rotation_images, created_at: service_created_at, updated_at: service_updated_at })
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

	def self.filter(params)
		@bikes = Bike.all
		
		begin
			@bikes =  Bike.joins(:bike_type).where(bike_types: { name: params[:bike_type]}) if params[:bike_type]         	 
		rescue
			"No Bikes"
		end
		begin
			@bikes = @bikes.where(bike_price: (params[:start_price_value].to_i)..(params[:end_price_value].to_i)) if params[:start_price_value]
		rescue
			"No Bikes"
		end
		begin
			@bikes = @bikes.where(bike_cc: (params[:minimum_cc].to_i)..(params[:maximum_cc].to_i)) if params[:minimum_cc]     	 
		rescue
			"No Bikes"
		end
		begin	
			@bikes = @bikes.gear(params[:gear]) if params[:gear]           	 
		rescue
			"No Bikes"
		end

		
		return @bikes
	end

	#for compare changes
	def self.compare(params)
		bike_compare_data = []
		params[:compare_ids].each do |bike|
			@bike = Bike.find_by_id(bike)
			bike_compare_data << @bike.display_car_data(@bike) if @bike
		end

		return {"overview": bike_compare_data}
	end

	def display_car_data(bike)
		var = []
		bike.attributes.each do |k, v|
			var << { "#{k}": v }
		end
        techinical_data = bike.specifications.where(compare_visible: true).order(:specification_type_id)
	    return {bike_type_name: bike.bike_type.name, default_image: bike.default_bike_image.try(:image_url), bike_name: bike.name, bike_values: var, colors: bike.bike_colors.where(compare_visible: true), specifications: techinical_data }
	end

end
