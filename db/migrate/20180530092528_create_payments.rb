class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :txn_id
      t.integer :user_id
      t.string :entity_type
      t.decimal :amount,            precision: 8, scale: 2, default: 0.0
      t.string :status,             default: "Generated"
      t.integer :merchant_id
      t.string :payment_type
      t.string :location
      t.string :vehicle_name
      t.integer :bike_id
      t.string :mihpayid
      t.string :image
      t.string :web_pay_image
      t.string :file_type
      t.string :payuid
      t.text :message
      t.boolean :refund
      t.integer :dealer_id
      t.string :phone
      t.string :booking_person_name
      t.string :payment_mode
      t.string :split_status
      t.string :release_status
      t.integer :split_payment_id
      t.integer :child_payment_id
      t.integer :refund_id

      t.timestamps null: false
    end
  end
end
