class Web::V1::HogRegistrationsSerializer < ActiveModel::Serializer
  
  attributes :id, :full_name, :mobile, :email, :dob, :show_hog, :gender, :bike_owned, :riding_since, :address, :location, :profession, :bio, :hog_privacy, :profile_image, :user_id

  def dob
   object.dob.strftime("%d/%m/%Y") if object.dob
  end

end