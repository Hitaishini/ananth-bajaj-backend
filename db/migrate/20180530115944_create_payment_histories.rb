class CreatePaymentHistories < ActiveRecord::Migration
  def change
    create_table :payment_histories do |t|
      t.integer :payment_id
      t.string :status

      t.timestamps null: false
    end
  end
end
