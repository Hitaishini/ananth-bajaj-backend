class Website::V1::AccessorySerializer < ActiveModel::Serializer
	attributes :id, :title, :description, :tag, :image, :accessory_category_id, :part_number, :size, :price

	def attributes
		data = super
    if current_user && current_user.wishlist.accessories.pluck(:id).include?(data[:id])
			#current_user.wishlist.accessories.each do 
			 data[:active] = "true"
			 data
   	else
			 data[:active] = "false"
			 data
   	end
		#data[:bike_name] = Bike.find_by_id(data[:bike_id]).try(:name)
	end

end