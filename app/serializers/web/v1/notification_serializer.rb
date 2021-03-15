class Web::V1::NotificationSerializer < ActiveModel::Serializer
  attributes :id, :action

  def attributes
  	data = super
  	notification = Notification.find(data[:id])
  	template = notification.notification_template || notification.bulk_notification
  	data[:title] = template.try(:title)
  	data[:description] = template.try(:content)
    if template && template.has_attribute?("image") &&  template.image && template.image.url
        data[:image] = template.has_attribute?("image") ? ("https://anant-bajaj-dev.myridz.com" + template.image.url) : nil
    else
      data[:image] = nil
    end
  	names = []
  	Notification.where(parent_id: notification.id).each do |notn|
  		names << notn.try(:recipient).try(:profile).try(:full_name) || 'NA'
  	end	
  	data[:user_name] = names.empty? ? notification.try(:recipient).try(:profile).try(:full_name) || 'NA' : names 
    data[:created_at] = object.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
    data[:updated_at] = object.updated_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
    data
  end  
end
