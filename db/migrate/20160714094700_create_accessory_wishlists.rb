class CreateAccessoryWishlists < ActiveRecord::Migration[5.1]
  def change
    create_table :accessory_wishlists do |t|
      t.integer :accessory_id
      t.integer :wishlist_id

      t.timestamps null: false
    end
  end
end
