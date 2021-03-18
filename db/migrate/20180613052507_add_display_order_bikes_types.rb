class AddDisplayOrderBikesTypes < ActiveRecord::Migration[5.1]
  def change
  	add_column :bike_types, :display_order, :integer
  end
end
