class Web::V1::ServiceBookingSerializer < ActiveModel::Serializer	
	attributes :id, :service_type, :user_id, :my_bike_id, :registration_number, :kms, :service_date, :service_time, :service_station, :comments, :request_pick_up, :status, :address

	def attributes
		data = super
		if data[:service_time].present?
			data[:service_time] = (data[:service_time]).strftime("%H:%M:%S %p")
		else
			data[:service_time] = "nul"
		end
		data[:my_bike_name] = (MyBike.find(data[:my_bike_id]).bike if MyBike.exists?(data[:my_bike_id])) || "N/A"
		data[:user_email] = User.find_by_id(object.user_id).try(:email) if User.exists?(object.user_id) || "N/A"#(MyBike.find(data[:my_bike_id]).user.try(:email) if MyBike.exists?(data[:my_bike_id])) || "N/A"
		data[:user_name] = User.find_by_id(object.user_id).try(:profile).try(:full_name) if User.exists?(object.user_id) || "N/A"#(MyBike.find(data[:my_bike_id]).user.try(:profile).try(:full_name) if MyBike.exists?(data[:my_bike_id])) || "N/A"
		data[:user_mobile] =  User.find_by_id(object.user_id).try(:profile).try(:mobile) if User.exists?(object.user_id) || "N/A"#(MyBike.find(data[:my_bike_id]).user.try(:mobile) if MyBike.exists?(data[:my_bike_id])) || "N/A"
		data[:created_at] = object.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
		data[:updated_at] = object.updated_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')  	
		data
	end
end