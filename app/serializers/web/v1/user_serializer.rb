class Web::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :authentication_token, :role, :created_at, :updated_at

  has_one :profile

   def created_at
	object.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
   end
   def updated_at
  	object.updated_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
  end

end
