class Web::V1::SpecificationSerializer < ActiveModel::Serializer
  attributes :id, :name, :value, :active, :bike_id, :compare_visible, :specification_type_id, :specification_name_id, :updated_at

  def attributes
  	data = super
  	data[:bike_name] = Bike.find_by_id(data[:bike_id]).try(:name)
  	data[:specification_type] = SpecificationType.find_by_id(data[:specification_type_id]).try(:name)
  	data[:specifi_name] = SpecificationName.find_by_id(data[:specification_name_id]).try(:name)
  	data[:created_at] = object.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
  	data[:updated_at] = object.updated_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
  	data
  end

  
end