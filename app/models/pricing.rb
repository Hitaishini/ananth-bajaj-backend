class Pricing < ActiveRecord::Base
	audited
	belongs_to :bike
	belongs_to :price_field
	belongs_to :varient


	def self.varient_split_add(params)
		varient_ids = params[:pricing][:varient_id]
		varient_ids.each do |id|
			params[:pricing][:varient_id] = id
			price_value = Pricing.new(params.require(:pricing).permit(:value, :price_field_id, :bike_id, :active, :varient_id))
			price_value.save
		end	
		return true
	end


	def price_field_type
		PriceField.find_by_id(self.price_field_id).try(:name)
	end

	def bike_type
		Bike.find_by_id(self.bike_id).try(:name)
	end
	def service_created_at
		self.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end
	def service_updated_at
		self.updated_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end		

	def display_order
		PriceField.find_by_id(self.price_field_id).try(:display_order)
	end

	def variant_price_name
		self.varient.try(:varient_name) if self.varient
	end

	def as_json(options={})
		super.as_json(options).merge({ :bike_name => bike_type, :price_field_type => price_field_type, display_order: display_order, created_at: service_created_at, updated_at: service_updated_at, varient_name: variant_price_name})
	end

	
def self.import(file)
		price_field_ex = PriceField.find_by_name("Ex Showroom Price").id	
		price_field_road_tax = PriceField.find_by_name("On Road Price with Insurance").id	
		price_field_insu = PriceField.find_by_name("Insurance").id	
		price_field_ins_free = PriceField.find_by_name("Insurance (1 year OD & 5 years TP & PA)").id	
		price_field_rto = PriceField.find_by_name("LTT Charges & RTO").id
		price_field_on_road_without_ins = PriceField.find_by_name("On Road Price without Insurance").id
		price_field_on_road_price = PriceField.find_by_name("On Road Price").id
		price_field_handling_charg = PriceField.find_by_name("Handling charges").id
		price_field_reg_charges = PriceField.find_by_name("Registration Charges").id
		# price_field_smart_char = PriceField.find_by_name("Smart Card Charges").id	
		# price_field_warrenty = PriceField.find_by_name("Extended Warranty").id		
		# price_field_road = PriceField.find_by_name("On Road Price").id

          count = 0
		CSV.foreach(file.path, headers: true, encoding:'iso-8859-1:utf-8') do |row|
			count += 1
			att = row.to_hash
			logger.info "=================fsdfsdfsdfsfsf====#{att}"
			if att["varients"]
				varients = att["varients"].split(",").map { |s| s }
				att.delete("varients")
				varients.each do |var|
					att["varient_id"] = var
					price_value = find_by_id(att["id"]) || PriceValue.new#.require(:price_value).permit(:price_field_value, :price_field_id, :varient_id, :city))
					price_value.attributes = att
					price_value.save!
				end
			else
				#binding.pry
				car = Bike.find_by_name(att['model'])
				varient = car.varients.where(varient_name: att["variant"]).try(:first).try(:id) if car
	           if varient
					(a = Pricing.where(bike_id: car.id, price_field_id: price_field_ex, varient_id: varient).first) ? a.update(bike_id: car.id, value: att["Ex Showroom Price"]) : Pricing.create(bike_id: car.id, value: att["Ex Showroom Price"], price_field_id: price_field_ex, varient_id: varient)
					(a = Pricing.where(bike_id: car.id, price_field_id: price_field_road_tax, varient_id: varient).first) ? a.update(bike_id: car.id, value: att["On Road Price with Insurance"]) : Pricing.create(bike_id: car.id, value: att["On Road Price with Insurance"], price_field_id: price_field_road_tax, varient_id: varient)
					(a = Pricing.where(bike_id: car.id, price_field_id: price_field_insu, varient_id: varient).first) ? a.update(bike_id: car.id, value: att["Insurance"]) : Pricing.create(bike_id: car.id, value: att["Insurance"], price_field_id: price_field_insu, varient_id: varient)
					(a = Pricing.where(bike_id: car.id, price_field_id: price_field_ins_free, varient_id: varient).first) ? a.update(bike_id: car.id, value: att["Insurance (1 year OD & 5 years TP & PA)"]) : Pricing.create(bike_id: car.id, value: att["Insurance (1 year OD & 5 years TP & PA)"], price_field_id: price_field_ins_free, varient_id: varient)
					(a = Pricing.where(bike_id: car.id, price_field_id: price_field_rto, varient_id: varient).first) ? a.update(bike_id: car.id, value: att["LTT Charges & RTO"]) : Pricing.create(bike_id: car.id, value: att["LTT Charges & RTO"], price_field_id: price_field_rto, varient_id: varient)
					(a = Pricing.where(bike_id: car.id, price_field_id: price_field_on_road_without_ins, varient_id: varient).first) ? a.update(bike_id: car.id, value: att["On Road Price without Insurance"]) : Pricing.create(bike_id: car.id, value: att["On Road Price without Insurance"], price_field_id: price_field_on_road_without_ins, varient_id: varient)
					(a = Pricing.where(bike_id: car.id, price_field_id: price_field_on_road_price, varient_id: varient).first) ? a.update(bike_id: car.id, value: att["On Road Price"]) : Pricing.create(bike_id: car.id, value: att["On Road Price"], price_field_id: price_field_on_road_price, varient_id: varient)
					(a = Pricing.where(bike_id: car.id, price_field_id: price_field_handling_charg, varient_id: varient).first) ? a.update(bike_id: car.id, value: att["Handling charges"]) : Pricing.create(bike_id: car.id, value: att["Handling charges"], price_field_id: price_field_handling_charg, varient_id: varient)
					(a = Pricing.where(bike_id: car.id, price_field_id: price_field_reg_charges, varient_id: varient).first) ? a.update(bike_id: car.id, value: att["Registration Charges"]) : Pricing.create(bike_id: car.id, value: att["Registration Charges"], price_field_id: price_field_reg_charges, varient_id: varient)
				else
					logger.info "=================Missed================="
					logger.info att.inspect
				end
		    end	
			logger.info "=================anil====#{count}===		"
		end
	end


	def self.to_csv(options = {})
		CSV.generate(options) do |csv|
			csv << ["model", "variant", "Ex Showroom Price", "Insurance", "Insurance (1 year OD & 5 years TP & PA)", "LTT Charges & RTO", "On Road Price with Insurance", "On Road Price without Insurance", "On Road Price", "Handling charges", "Registration Charges" ]
		end
	end


	def self.generate_csv(bike_name, varient)
		CSV.generate() do |csv|
			csv << ["model", "variant", "Ex Showroom Price", "Insurance", "Insurance (1 year OD & 5 years TP & PA)", "LTT Charges & RTO", "On Road Price with Insurance", "On Road Price without Insurance", "On Road Price", "Handling charges", "Registration Charges"]
			
			cars = bike_name ? Bike.where(name: bike_name) : Bike.all

			cars.each do |car|
				varients = car.varients
				varients = varients.where(varient_name: varient) if varient
				if varients
					varients.each do |varient|
						data = []
						data << car.try(:name) || 'N/A'
						data << varient.try(:varient_name) || 'N/A'
						data << varient.pricings.where(price_field_id: PriceField.find_by_name("Ex Showroom Price").try(:id)).try(:first).try(:value) || 'N/A'
						data << varient.pricings.where(price_field_id: PriceField.find_by_name("LTT Charges & RTO").try(:id)).try(:first).try(:value) || 'N/A'
						data << varient.pricings.where(price_field_id: PriceField.find_by_name("Insurance").try(:id)).try(:first).try(:value) || 'N/A'
						data << varient.pricings.where(price_field_id: PriceField.find_by_name("Insurance (1 year OD & 5 years TP & PA)").try(:id)).try(:first).try(:value) || 'N/A'
						data << varient.pricings.where(price_field_id: PriceField.find_by_name("On Road Price with Insurance").try(:id)).try(:first).try(:value) || 'N/A'
						data << varient.pricings.where(price_field_id: PriceField.find_by_name("On Road Price without Insurance").try(:id)).try(:first).try(:value) || 'N/A'
						data << varient.pricings.where(price_field_id: PriceField.find_by_name("On Road Price").try(:id)).try(:first).try(:value) || 'N/A'
						data << varient.pricings.where(price_field_id: PriceField.find_by_name("Handling charges").try(:id)).try(:first).try(:value) || 'N/A'
						data << varient.pricings.where(price_field_id: PriceField.find_by_name("Registration Charges").try(:id)).try(:first).try(:value) || 'N/A'
						
					  csv << data
					end
				end		
			end	
		end
	end



end
