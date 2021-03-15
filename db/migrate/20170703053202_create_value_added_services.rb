class CreateValueAddedServices < ActiveRecord::Migration
  def change
    create_table :value_added_services do |t|
      t.string :name
      t.string :email
      t.string :mobile
      t.string :model
      t.date :date_of_purchase
      t.string :frame_number
      t.text :select_scheme
      t.text :description

      t.timestamps null: false
    end
  end
end
