class CreateServiceNumbers < ActiveRecord::Migration[5.1]
  def change
    create_table :service_numbers do |t|
      t.string :contact_name
      t.string :contact_number

      t.timestamps null: false
    end
  end
end
