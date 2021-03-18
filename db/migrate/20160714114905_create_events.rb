class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.date :event_date
      t.time :event_time
      t.string :location
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
