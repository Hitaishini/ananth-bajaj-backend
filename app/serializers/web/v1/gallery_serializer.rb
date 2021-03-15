class Web::V1::GallerySerializer < ActiveModel::Serializer
 attributes :id, :bike_id, :image, :bike_name, :created_at, :updated_at

 def bike_name
   object.bike.try(:name)
 end

 def created_at
   object.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
 end
 def updated_at
   object.updated_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
 end

end