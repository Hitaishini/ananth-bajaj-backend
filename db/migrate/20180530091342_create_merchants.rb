class CreateMerchants < ActiveRecord::Migration[5.1]
  def change
    create_table :merchants do |t|
      t.string :merchant_id
      t.string :salt
      t.string :name
      t.string :location
      t.string :merchant_type
      t.string :merchant_key
      t.string :mobile
      t.string :email
      t.string :authorization
      t.text :payment_for
      t.text :dealer_id

      t.timestamps null: false
    end
  end
end
