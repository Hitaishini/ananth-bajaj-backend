class MyBike < ApplicationRecord
	belongs_to :user
	belongs_to :default_bike_image
	has_many :service_bookings
	has_many :service_histories
	mount_base64_uploader :bike_image, ImageUploader, file_name: 'my_bike'
	#insurense
	has_many :insurance_renewals
    
    #call backs
	#before_update :remove_old_image_assign_new
	after_create :create_bike_id
	#after_update :my_bike_update_image
	
	def km_exceeds_for_months
		date1 = Date.today
		date2 = purchase_date
		purchased_month = (date2.year * 12 + date2.month) - (date1.year * 12 + date1.month)
		bike = Bike.find_by_name(bike)
		if bike
			service_schedule = bike.service_schedules.where("months >= ?", purchased_month).first
			return true if (service_schedule.total_kms - service_schedule.range) <= (self.kms).to_i
		else
			return false
		end

	end	

	def service_history
		self.service_histories
	end

	def user_email
		self.user.try(:email)
	end

	def my_bike_brand
		Bike.find_by_id(self.bike_id).try(:brand) || "N/A"
	end	

	def service_created_at
		self.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end
	def service_updated_at
		self.updated_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end

 	def as_json(options={})
		super.as_json(options).merge({:service_histories => service_history, :user_mail => user_email, bike_brand: my_bike_brand, created_at: service_created_at, updated_at: service_updated_at })
	end
	
	private

	def create_bike_id
		unless self.bike_image.present?
			bikes = Bike.all
			bike = Bike.find_by_name(self.bike)
			default_bike = Bike.find_by_name("others")
			if bike.present?
				bike_image = bike.default_bike_image.try(:image_url)
				self.update(bike_id: bike.id, my_bike_image_url: bike_image)
			else
				default_image = default_bike.default_bike_image.try(:image_url) if default_bike
				self.update(my_bike_image_url: default_image)
			end
		end
	end


	def remove_old_image_assign_new
		self.remove_bike_image! if self.bike_image.present?
	end

end
