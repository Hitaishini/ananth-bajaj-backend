class ChangeDefaultValueIn < ActiveRecord::Migration[5.1]
  def change
  	remove_column :profiles, :marriage_anniversary_date
  	add_column :profiles, :marriage_anniversary_date, :date
  end
end
