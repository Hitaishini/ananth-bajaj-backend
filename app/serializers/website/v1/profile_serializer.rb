class Website::V1::ProfileSerializer < ActiveModel::Serializer
  attributes :full_name, :mobile, :dob, :email, :gender, :bike_owned, :riding_since, :address, :location, :profession, :bio, :hog_privacy, :profile_image, :user_id
end
