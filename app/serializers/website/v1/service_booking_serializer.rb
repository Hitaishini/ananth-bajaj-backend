class Website::V1::ServiceBookingSerializer < ActiveModel::Serializer
  attributes :service_type, :user_id, :my_bike_id, :registration_number, :kms, :service_date, :service_time, :service_station, :comments, :request_pick_up, :service_status, :address
 
  def attributes
  	data = super
  	data[:my_bike] = MyBike.find_by_id(data[:my_bike_id]).try(:bike)
  	data[:user] = User.find_by_id(data[:user_id]).try(:profile).try(:full_name)
  	# data[:service_time] = (data[:service_time]).strftime("\%I:%M:%S %p")
  	# data[:service_date] = (data[:service_date]).strftime("%B %d, %Y")
  	data
	end
  

end