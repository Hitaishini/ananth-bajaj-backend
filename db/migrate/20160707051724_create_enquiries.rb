class CreateEnquiries < ActiveRecord::Migration[5.1]
  def change
    create_table :enquiries do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :category
      t.text :message

      t.timestamps null: false
    end
  end
end
