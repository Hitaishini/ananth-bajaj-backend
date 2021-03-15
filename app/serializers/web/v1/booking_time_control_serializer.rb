class Web::V1::BookingTimeControlSerializer < ActiveModel::Serializer
  
  attributes :id, :open_time, :end_time, :category, :days_prior, :weekday, :active

  def attributes
  	data = super
  	data[:open_time] = (data[:open_time]).strftime("%H:%M:%S %p")
  	data[:end_time] = (data[:end_time]).strftime("%H:%M:%S %p")
  	data
  end

end