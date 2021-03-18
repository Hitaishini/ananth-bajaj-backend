class CreateDealerContactLabels < ActiveRecord::Migration[5.1]
  def change
    create_table :dealer_contact_labels do |t|
      t.string :label_name

      t.timestamps null: false
    end
  end
end
