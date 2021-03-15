class Web::V1::ProfileSerializer < ActiveModel::Serializer
  attributes :full_name, :mobile, :dob, :email, :gender, :bike_owned, :riding_since, :address, :location, :profession, :bio, :hog_privacy, :profile_image, :user_id, :marriage_anniversary_date

  def attributes
  	data = super
  	data[:role] = object.user.role
  	data[:android_token] = object.user.try(:android_token)
  	data[:ios_token] = object.user.try(:ios_token)
  	data[:created_at] = object.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
  	data[:updated_at] = object.updated_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
  	data
  end
end
