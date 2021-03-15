class Web::V1::SpecificationTypeSerializer < ActiveModel::Serializer
  attributes :id, :name, :display_order, :active, :created_at, :updated_at

  def created_at
   object.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
  end
  def updated_at
   object.updated_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
  end
end
