class CreateServiceHistories < ActiveRecord::Migration
  def change
    create_table :service_histories do |t|
      t.date :service_date
      t.string :service_type
      t.integer :kms
      t.string :total_cost
      t.integer :bike_id
      t.string :bill_image

      t.timestamps null: false
    end
  end
end
