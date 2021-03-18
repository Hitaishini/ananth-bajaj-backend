class CreateCustomerGalleries < ActiveRecord::Migration[5.1]
  def change
    create_table :customer_galleries do |t|
      t.string :video_url
      t.string :image

      t.timestamps null: false
    end
  end
end
