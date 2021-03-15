class Web::V1::TestRideSerializer < ActiveModel::Serializer
  
  attributes :id, :user_id, :address, :name, :mobile, :email, :request_pick_up, :test_ride_done, :test_ride_confirmed, :bike, :ride_date, :ride_time, :location

  def attributes
  	data = super
  	data[:ride_time] = (data[:ride_time]).strftime("%H:%M:%S %p")
  	data[:created_at] = object.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
  	data[:updated_at] = object.updated_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')  	
  	data
  end

end