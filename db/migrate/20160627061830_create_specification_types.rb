class CreateSpecificationTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :specification_types do |t|
      t.string :name
      t.integer :display_order
      t.boolean :active

      t.timestamps null: false
    end
  end
end
