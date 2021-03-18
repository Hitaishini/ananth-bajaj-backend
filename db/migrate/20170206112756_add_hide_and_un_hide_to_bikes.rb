class AddHideAndUnHideToBikes < ActiveRecord::Migration[5.1]
  def change
  	add_column :bikes, :visible, :boolean, default: true
  end
end
