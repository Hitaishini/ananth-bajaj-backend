class CreateVehicleFaqs < ActiveRecord::Migration[5.1]
  def change
    create_table :vehicle_faqs do |t|
    	t.string :bike_type
    	t.string :type
    	t.string :specification
    	t.string :value
    	t.belongs_to :bike, index: true
      t.timestamps null: false
    end
  end
end
