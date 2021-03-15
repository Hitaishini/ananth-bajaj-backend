class Website::V1::BikeSerializer < ActiveModel::Serializer
  attributes :id, :name, :bike_image, :display_order, :pricing, :brand, :total_price, :bike_cc, :visible, :bike_type, :variant_data, :bike_brochure_url, :non_bajaj

  def bike_image
   object.default_bike_image.try(:image_url)
 end 

 def pricing
   object.try(:bike_price)
  	  #object.pricings.collect { |price| price.price_field }.map! { |price_field| price_field if price_field.name == "Ex-Showroom"}.compact
    end

    def bike_type
      object.bike_type.name if object.bike_type
    end

    def total_price
     object.pricings.where(price_field_id: 5).pluck(:value).join
   end

  def variant_data
      price_field_values = []
      object.varients.where(:visible => true).each do |varient|
       on_road_data = varient.price_fields.where(name: "On Road Price") ||  varient.price_fields
       on_road_data.each do |price_field|
        price_field_name = price_field.name
        price_field_values << { :varient => varient, :price_field_name => price_field_name, :price_field_values => price_field.pricings.where(varient_id: varient.id) }
      end
    end
    return price_field_values
  end

end