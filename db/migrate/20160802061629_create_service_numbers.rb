class CreateServiceNumbers < ActiveRecord::Migration
  def change
    create_table :service_numbers do |t|
      t.string :contact_name
      t.string :contact_number

      t.timestamps null: false
    end
  end
end
