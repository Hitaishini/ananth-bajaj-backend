class CreateAboutUsPages < ActiveRecord::Migration[5.1]
  def change
    create_table :about_us_pages do |t|
      t.string :image
      t.string :category

      t.timestamps null: false
    end
  end
end
