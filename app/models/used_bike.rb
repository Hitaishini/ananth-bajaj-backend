class UsedBike < ActiveRecord::Base
	belongs_to :used_bike_model
	belongs_to :user
	belongs_to :dealer
	has_many :used_bike_images
	accepts_nested_attributes_for :used_bike_images, :allow_destroy => true, :reject_if => lambda { |a| a['image'].blank? } 


	#for filter data
	def self.filter_data
		@used_bike = UsedBike.where(for_sell: false)
		bike_model_list = @used_bike.collect{|c| c.used_bike_model.try(:name)}.uniq
		@min_price = @used_bike.minimum(:price)
		@max_price = @used_bike.maximum(:price)
		@min_year = @used_bike.minimum(:manufacture_year)
		@max_year = @used_bike.maximum(:manufacture_year)
		@min_kms = @used_bike.minimum(:kms)
		@max_kms = @used_bike.maximum(:kms)
		bike_type = @used_bike.collect { |d| d.bike_type }.uniq.compact
		gear = @used_bike.collect { |d| d.gear }.uniq
		ownership =  @used_bike.collect { |d| d.ownership  }.uniq.compact
		@used_bike_data = []
		@used_bike_data << [:minimum_price => @min_price, :maximum_price => @max_price, :minimum_bike_year => @min_year, :maximum_bike_year => @max_year, :minimum_kms => @min_kms, :maximum_kms => @max_kms, :used_bike_filter_label => bike_model_list, :bike_type => bike_type, :gear => gear ,:ownership => ownership]
		@used_bike_data = @used_bike_data.flatten
		return @used_bike_data
	end

	#for filter
	def self.search(params)
		@used_bikes = UsedBike.where(for_sell: false)
		#where(:status => "Available")
		begin
			@used_bikes = @used_bikes.joins(:used_bike_model).where(used_bike_models: {name: params[:bike_model]}) if params[:bike_model].present? 
		rescue
			"No Used Bikes"
		end
		# begin
		# 	@used_bikes = @used_bikes.where(model: params[:bike_model]) if params[:bike_model].present? 
		# rescue
		# 	"No Used Bikes"
		# end
		begin
			@used_bikes = @used_bikes.where(bike_type: params[:bike_type]) if params[:bike_type].present? 
		rescue
			"No Used Bikes"
		end
		begin
			@used_bikes = @used_bikes.where(price: (params[:start_price].to_i)..(params[:end_price].to_i)) if params[:start_price].present?
		rescue
			"No Used Bikes"
		end
		begin
			@used_bikes = @used_bikes.where(manufacture_year: (params[:bike_start_year].to_i)..(params[:bike_end_year].to_i)) if params[:bike_start_year].present?
		rescue
			"No Used Bikes"
		end
		begin
			@used_bikes = @used_bikes.where(kms: (params[:start_kms].to_i)..(params[:end_kms].to_i)) if params[:start_kms].present?
		rescue
			"No Used Bikes"
		end
		begin
			@used_bikes = @used_bikes.where(ownership: params[:ownership]) if params[:ownership].present?
		rescue
			"No Used Bikes"
		end
		begin
			@used_bikes = @used_bikes.where(gear: params[:gear]) if params[:gear].present?
		rescue
			"No Used Bikes"
		end
		# begin
		# 	@used_cars = @used_cars.where(certified: true) if params[:certified].present?
		# rescue
		# 	"No Used Cars"
		# end
		#@used_cars = @cars.all
		return @used_bikes
	end

	def sell_bike_notify(noti_template, dealer_mail_template, customer_mail_template, params)
		user = User.find_by_id(self.user_id)
		if user
			template = NotificationTemplate.where(category: noti_template).last
			Notification.create(recipient: user, actor: user, action: 'Offer', notifiable: self, notification_template: template)
			UserMailer.delay.sell_bike(self, dealer_mail_template)
			UserMailer.delay.sell_bike_confirm(self, customer_mail_template)
		else
			UserMailer.delay.sell_bike(self, dealer_mail_template)
			UserMailer.delay.sell_bike_confirm(self, customer_mail_template)
		end
	end



		def self.generate_used_bike(used_bikes)
		CSV.generate() do |csv|
			csv << ["BikeType*", "Manufacturer Name*", "Bike Model*",  "Registration Number", "Manufacture Year", "Bike Colour*", "KMS*", "Bike Ownership", "Bike Price*","Contact Number*","Status","Dealer Name*"]
			csv << ["Superbike", 	"Honda",	"CB Shine",	"KA456767","2016","red"	,"1200","1"	,"450000"	,"8105768628","Available","Mysore Road"]
			csv << ["Motorcycle" ,	"Honda"	,"CB Hornet 160R","ka456766","2017","Black","1200"	,"2","50000",	"8105768628","Sold out",	"Mysore Road"]
		end
	end

 
	def self.import(file)
		CSV.foreach(file.path, headers: true) do |row| 
			used_bikes = find_by_id(row["id"]) || new
      used_bike = row.to_hash
      dealer_name = Dealer.find_by_dealer_name(used_bike["Dealer Name*"])
			used_bike_model = UsedBikeModel.find_by_name(used_bike["Manufacturer Name*"])
			if used_bike_model.present? 
			 @used_bike_model_id = used_bike_model.id
			else
			 	used_bike_model1 = UsedBikeModel.create(name: used_bike["Manufacturer Name*"])	
			  @used_bike_model_id = used_bike_model1.id
			end
			if used_bike["Status"] == "Available" || used_bike["Status"] == "available"
				used_bike_status = "Available"
			else
				used_bike_status = "Sold Out"
			end
			if used_bikes.id.present?
				used_bikes.update_attributes(bike_type:used_bike["BikeType*"],model: used_bike["Bike Model*"], registration_number:used_bike["Registration Number"], manufacture_year:used_bike["Manufacture Year"], kms:used_bike["KMS*"], color:used_bike["Bike Colour*"], ownership:used_bike["Bike Ownership"], price:used_bike["Bike Price*"], contact_number:used_bike["Contact Number*"], status:used_bike_status)
			else
				UsedBike.create(bike_type:used_bike["BikeType*"],model: used_bike["Bike Model*"], registration_number:used_bike["Registration Number"], manufacture_year:used_bike["Manufacture Year"], kms:used_bike["KMS*"], color:used_bike["Bike Colour*"], ownership:used_bike["Bike Ownership"], price:used_bike["Bike Price*"], contact_number:used_bike["Contact Number*"], status:used_bike_status,dealer_id: dealer_name.try(:id),used_bike_model_id:@used_bike_model_id)
			end

		end
	end
	

end
