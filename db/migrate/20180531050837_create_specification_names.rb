class CreateSpecificationNames < ActiveRecord::Migration[5.1]
  def change
    create_table :specification_names do |t|
      t.string :name
      t.integer :specification_type_id

      t.timestamps null: false
    end
  end
end
