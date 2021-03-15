class CreateJointTable < ActiveRecord::Migration
  def change
    create_table :dealer_types_dealers do |t|
      t.integer :dealer_id
      t.integer :dealer_type_id

      t.timestamps null: false
    end
  end
end
