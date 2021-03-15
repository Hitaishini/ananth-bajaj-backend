class Website::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :authentication_token, :role,:facebook_id, :sign_in_count, :current_sign_in_at

  has_one :profile

  def attributes
  	data = super
  	data[:notification_count] = NotificationCount.find_by_user_id(data[:id]).try(:count) || 0
  	#data[:authentication_token] = @options[:token]
  	data
  end
end
