class Web::V1::UserInformationSerializer < ActiveModel::Serializer
 attributes :id, :user_id, :ride_id, :perticipate_ride, :user_name, :user_email, :user_number, :user_ride_date, :created_at

 def user_name
   object.user.try(:profile).try(:full_name) || 'N/A'
 end

 def user_email
   object.user.email
 end

 def user_number
   object.user.try(:profile).try(:mobile) || 'N/A'
 end

 def user_ride_date
   object.ride.try(:ride_date)
 end

 def created_at
  object.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
 end

end