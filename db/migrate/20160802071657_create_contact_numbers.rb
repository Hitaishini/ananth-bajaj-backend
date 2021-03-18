class CreateContactNumbers < ActiveRecord::Migration[5.1]
  def change
    create_table :contact_numbers do |t|
      t.string :category
      t.string :number
      t.string :label

      t.timestamps null: false
    end
  end
end
