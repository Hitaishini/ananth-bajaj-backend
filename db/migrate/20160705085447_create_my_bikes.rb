class CreateMyBikes < ActiveRecord::Migration[5.1]
  def change
    create_table :my_bikes do |t|
      t.string :bike
      t.date :purchase_date
      t.string :registration_number
      t.string :insurance_provider
      t.string :insurance_number
      t.date :insurance_expiry_date
      t.string :engine_number
      t.date :last_service_date
      t.integer :user_id
      t.string :bike_image
      t.integer :kms

      t.timestamps null: false
    end
  end
end
