class CreateServiceSchedules < ActiveRecord::Migration
  def change
    create_table :service_schedules do |t|
      t.string :service_number
      t.integer :bike_id
      t.string :months
      t.integer :total_kms
      t.string :service_type
      t.integer :range
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
