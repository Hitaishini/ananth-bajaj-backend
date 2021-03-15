class Web::V1::EmailPriceSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :mobile, :varient_name, :car_name , :followed_up, :comments, :created_at, :updated_at

  	def created_at
		object.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end

	def updated_at
		object.updated_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end

	def car_name
		var = Varient.find_by_id(object.varient_id)
		return var.try(:bike).try(:name)
	end

	def varient_name
		Varient.find_by_id(object.varient_id).try(:varient_name)
	end

end
