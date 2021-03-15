class Web::V1::VehicleFaqSerializer < ActiveModel::Serializer
	attributes :id, :bike_type ,:bike_name ,:value, :bike_id, :cate_gory_type , :specification , :updated_at, :created_at


  def bike_name
   object.bike.try(:name)
  end


  def attributes
  	data = super
  	data[:created_at] = object.created_at.strftime('%d-%m-%y %H:%M')
  	data[:updated_at] = object.updated_at.strftime('%d-%m-%y %H:%M')  	
  	data
  end

  
end