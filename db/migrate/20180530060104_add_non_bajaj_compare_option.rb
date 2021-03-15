class AddNonBajajCompareOption < ActiveRecord::Migration
  def change
  	add_column :bikes, :compare_vehicles, :text
  end
end
