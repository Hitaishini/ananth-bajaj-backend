class Website::V1::NotificationSerializer < ActiveModel::Serializer
 attributes :id, :action, :status, :title, :created_at

 def attributes
     data = super
     notification = Notification.find(data[:id])
     template = notification.notification_template || notification.bulk_notification
   #content, title  = template.fill_keywords(notification.notifiable, notification.recipient)
   data[:title] = title || "N/A"
     data[:image] = template.try(:image).try(:url) ? ("https://anant-bajaj-dev.myridz.com" + template.image.url) : nil
     data[:description] = object.content || "N/A"
   data
 end  
end