class Website::V1::ContactNumbersSerializer < ActiveModel::Serializer
  attributes :id, :category, :number, :label, :contact_type_id
end