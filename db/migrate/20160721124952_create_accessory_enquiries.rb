class CreateAccessoryEnquiries < ActiveRecord::Migration[5.1]
  def change
    create_table :accessory_enquiries do |t|
      t.integer :user_id
      t.integer :accessory_id

      t.timestamps null: false
    end
  end
end
