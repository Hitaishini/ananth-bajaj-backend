class SpecificationName < ApplicationRecord
	has_many :specifications
	belongs_to :specification_type


  def service_created_at
    self.created_at.in_time_zone('Chennai').strftime('%d-%m-%Y %l:%M %p')
  end


  def service_updated_at
    self.updated_at.in_time_zone('Chennai').strftime('%d-%m-%Y %l:%M %p')
  end

  def specification_type
    SpecificationType.find_by_id(specification_type_id).try(:name)
  end  

  def as_json(options={})
    super.as_json(options).merge({specification_type: specification_type, created_at: service_created_at, updated_at: service_updated_at })
  end
end
