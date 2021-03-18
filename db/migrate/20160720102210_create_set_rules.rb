class CreateSetRules < ActiveRecord::Migration[5.1]
  def change
    create_table :set_rules do |t|
      t.integer :days
      t.string :category
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
