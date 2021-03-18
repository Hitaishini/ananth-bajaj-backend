class AddFieldsToUsedBikeEnquiry < ActiveRecord::Migration[5.1]
  def change
  	add_column :used_bike_enquiries, :name, :string
  	add_column :used_bike_enquiries, :mobile, :string
  	add_column :used_bike_enquiries, :address, :string
  end
end
