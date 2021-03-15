class Web::V1::UsedBikeSerializer < ActiveModel::Serializer
  
  attributes :id, :make_coompany, :model, :contact_number, :bike_variant, :status, :dealer_id, :used_bike_model_id, :registration_number, :bike_type, :manufacture_year, :kms, :gear, :color, :ownership, :price, :under_warrenty, :used_bike_model, :user_id, :user_name, :dealer_name, :for_sell, :image_exists
  
  has_many :used_bike_images

  def used_bike_model
  	object.used_bike_model.try(:name)  
  end

  def user_name
    Profile.find_by_user_id(object.user_id).try(:full_name)
  end

  def dealer_name
  	object.try(:dealer).try(:dealer_name) 
  end

  def image_exists
  	object.used_bike_images.collect { |f| f.image if f.image.url.present? }.compact.any? ? true : false
  end

end