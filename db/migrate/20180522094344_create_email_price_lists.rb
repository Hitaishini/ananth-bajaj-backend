class CreateEmailPriceLists < ActiveRecord::Migration
  def change
    create_table :email_price_lists do |t|
      t.string :name
      t.string :mobile
      t.string :email
      t.integer :varient_id
      t.boolean :followed_up
      t.integer :user_id
      t.string  :comments

      t.timestamps null: false
    end
  end
end
