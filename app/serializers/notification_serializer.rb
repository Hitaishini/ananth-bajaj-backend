class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :action

  def attributes
  	data = super
  	notification = Notification.find(data[:id])
  	template = notification.notification_template
  	data[:title] = template.try(:title)
  	data[:description] = template.try(:content)
  	names = []
  	Notification.where(parent_id: notification.id).each do |notn|
  		names << notn.try(:recipient).try(:profile).try(:full_name) || 'NA'
  	end	
  	data[:user_name] = names.empty? ? notification.try(:recipient).try(:profile).try(:full_name) || 'NA' : names 
    data
  end  
end
