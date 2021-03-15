class Web::V1::UserEventInformationSerializer < ActiveModel::Serializer
 attributes :id, :user_id, :event_id, :perticipate_event, :user_name, :user_email, :user_number, :event_date, :created_at

 def user_name
   object.user.try(:profile).try(:full_name)
 end

 def user_email
   object.user.email
 end

 def user_number
   object.user.try(:profile).try(:mobile)
 end

 def created_at
  object.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
 end

end