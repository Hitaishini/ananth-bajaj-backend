class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :full_name
      t.string :mobile
      t.string :email
      t.date :dob
      t.string :gender
      t.string :bike_owned
      t.string :riding_since
      t.string :address
      t.string :location
      t.string :profession
      t.text :bio
      t.boolean :hog_privacy, default: false
      t.string :profile_image
      t.integer :user_id

      t.timestamps null: false
    end

    create_table :hog_registrations do |t|
      t.string :full_name
      t.string :email
      t.string :mobile
      t.date :dob
      t.string :gender
      t.string :bike_owned
      t.string :riding_since
      t.string :address
      t.string :location
      t.string :profession
      t.text :bio
      t.boolean :hog_privacy
      t.string :profile_image
      t.integer :user_id
      t.boolean :show_hog, default: false

      t.timestamps null: false
    end
  end
end