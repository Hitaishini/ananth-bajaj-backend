class CreateDealers < ActiveRecord::Migration[5.1]
  def change
    create_table :dealers do |t|
      t.string :dealer_name
      t.string :address
      t.integer :dealer_type_id
      t.string :working_hours
      t.string :email
      t.string :latitude
      t.string :longitude
      t.boolean :active, default: true
      t.string :image
      t.integer :service_display_order
      t.integer :sales_display_order

      t.timestamps null: false
    end
  end
end
