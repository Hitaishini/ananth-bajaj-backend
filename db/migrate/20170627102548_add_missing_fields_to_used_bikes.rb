class AddMissingFieldsToUsedBikes < ActiveRecord::Migration[5.1]
  def change
  	add_column :used_bikes, :contact_number, :string
  	add_column :used_bikes, :bike_variant, :string
  	add_column :used_bikes, :status, :string
  	add_column :used_bikes, :dealer_id, :integer
  end
end
