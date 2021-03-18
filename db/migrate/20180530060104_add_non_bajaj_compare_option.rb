class AddNonBajajCompareOption < ActiveRecord::Migration[5.1]
  def change
  	add_column :bikes, :compare_vehicles, :text
  end
end
