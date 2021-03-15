class CreateUserRides < ActiveRecord::Migration
  def change
    create_table :user_rides do |t|
      t.integer :user_id
      t.integer :ride_id

      t.timestamps null: false
    end
  end
end
