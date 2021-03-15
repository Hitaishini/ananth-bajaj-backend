10.times do
	user = User.new
	user.email = FFaker::Internet.safe_email
	user.password = "Secret#123"
	user.role = ["super-admin", "dealer-admin", "dealer-manager"].shuffle.first
	user.save
end

50.times do
	user = User.new
	user.email = FFaker::Internet.safe_email
	user.password = "Secret#123"
	user.role = "guest"
	user.save
end

Profile.all.each do |profile|
	profile.update(:full_name => FFaker::Name.name, :mobile => FFaker::PhoneNumberCU.e164_home_work_phone_number, :dob => FFaker::IdentificationESCO.expedition_date, :gender => ["Male", "Female"].shuffle.first, :bike_owned => Bike.pluck(:name).shuffle.first, :riding_since => FFaker::Vehicle.year, :address => FFaker::AddressUS.street_address, :location => FFaker::AddressUS.city, :profession => FFaker::Job.title, :bio => FFaker::DizzleIpsum.paragraph, :hog_privacy => [true, false].shuffle.first, :profile_image => FFaker::Avatar.image)
end


10.times do
bike_type = BikeType.create(name: FFaker::Vehicle.model, tagline: FFaker::HipsterIpsum.sentence, available: true)
end

50.times do
bike = Bike.create(name: FFaker::Vehicle.make, description: FFaker::HipsterIpsum.sentence, tagline: FFaker::HipsterIpsum.sentence, available: true, bike_type_id: BikeType.pluck(:id).shuffle.first )
end

50.times do
	Specification.create( bike_id: Bike.pluck(:id).shuffle.first, name: FFaker::DizzleIpsum.word, specification_type_id: SpecificationType.pluck(:id).shuffle.first, value: FFaker::DizzleIpsum.word, active: true )
end

SpecificationType.create(name: "Dimensions", display_order: 1, active: true)
SpecificationType.create(name: "Engine", display_order: 2, active: true)
SpecificationType.create(name: "DriveTrain", display_order: 3, active: true)
SpecificationType.create(name: "Chassis", display_order: 4, active: true)
SpecificationType.create(name: "Performance", display_order: 5, active: true)
SpecificationType.create(name: "Electric", display_order: 6, active: true)



AccessoryCategory.create(title: "Bike Accessories", description: "Cool Bike Accessories", image: "http://www.google.com")
AccessoryCategory.create(title: "Clothing Accessories", description: "Cool Bike Clothing Accessories", image: "http://www.google.com")


40.times do
	Accessory.create(title: "Accessory", accessory_category_id: AccessoryCategory.pluck(:id).shuffle.first)
end

User.all.each do |user|
	Wishlist.create(user_id: user.id)
end