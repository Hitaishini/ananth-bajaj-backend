class CreateContactTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :contact_types do |t|
      t.string :label
      t.string :type

      t.timestamps null: false
    end
  end
end
