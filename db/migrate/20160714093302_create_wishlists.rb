class CreateWishlists < ActiveRecord::Migration[5.1]
  def change
    create_table :wishlists do |t|
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
