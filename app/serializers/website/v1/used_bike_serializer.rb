class Website::V1::UsedBikeSerializer < ActiveModel::Serializer
  
  attributes :id, :make_coompany, :model, :contact_number, :bike_variant, :status, :dealer_id, :used_bike_model_id, :registration_number, :bike_type, :manufacture_year, :kms, :gear, :color, :ownership, :price, :used_bike_model, :user_id, :dealer_name
  
  has_many :used_bike_images

  def used_bike_model
  	object.used_bike_model.try(:name)  
  end

  def dealer_name
  	object.try(:dealer).try(:dealer_name) 
  end

end