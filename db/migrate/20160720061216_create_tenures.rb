class CreateTenures < ActiveRecord::Migration[5.1]
  def change
    create_table :tenures do |t|
      t.string :month

      t.timestamps null: false
    end
  end
end
