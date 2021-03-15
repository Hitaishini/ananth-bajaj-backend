class Website::V1::SpecificationSerializer < ActiveModel::Serializer
  attributes :id, :name, :value, :active, :bike_id, :specification_type_id
  
  def attributes
  	data = super
  	data[:bike_name] = Bike.find_by_id(data[:bike_id]).try(:name)
  	data[:specification_type] = SpecificationType.find_by_id(data[:specification_type_id]).name
  	data
  end
  
end
