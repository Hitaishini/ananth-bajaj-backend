class CreateDealerContactNumbers < ActiveRecord::Migration
  def change
    create_table :dealer_contact_numbers do |t|
      t.string :number
      t.integer :dealer_id
      t.integer :dealer_contact_label_id

      t.timestamps null: false
    end
  end
end
