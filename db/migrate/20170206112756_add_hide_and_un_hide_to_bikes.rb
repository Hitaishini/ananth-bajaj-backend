class AddHideAndUnHideToBikes < ActiveRecord::Migration
  def change
  	add_column :bikes, :visible, :boolean, default: true
  end
end
