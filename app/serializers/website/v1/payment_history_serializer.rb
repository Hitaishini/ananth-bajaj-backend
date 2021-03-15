class Website::V1::PaymentHistorySerializer < ActiveModel::Serializer
 attributes :id, :txn_id, :user_id, :created_at

   def attributes
  	data = super
  	payment = object
    data[:payment_id]  = payment.id
  	data[:txn_id] = payment.try(:txn_id)
  	data[:user_id] = payment.user_id
  	data[:entity_type] = payment.entity_type
  	data[:amount] = payment.amount
  	data[:vehicle_name] = payment.vehicle_name
  	data[:user_name] = payment.try(:user).try(:profile).try(:full_name)
  	data[:merchant_name] = payment.merchant.try(:name)
  	data[:merchant_type] = payment.merchant.try(:merchant_type)
  	data[:merchant_location] = payment.merchant.try(:location)
    data[:bike_id] = payment.try(:bike_id)
    data[:mihpayid] = payment.try(:mihpayid)
    data[:payuid] = payment.try(:payuid)
    data[:file_type] = payment.file_type
    data[:image] = payment.image.url ? ("https://anant-bajaj-dev.myridz.com" + payment.image.url) : nil
  	data[:refund] = payment.try(:refund) 
    data[:dealer_name] = payment.try(:dealer).try(:dealer_name)
    data[:created_at] = payment.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M %p')
    data[:updated_at] = payment.updated_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M %p')
    data[:reg_no] = MyBike.find_by_bike_and_user_id("#{payment.vehicle_name}","#{payment.user_id}").try(:registration_number)
    data[:status] = payment.status
    data
	end

end
