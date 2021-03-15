class ChangeFiledsToEvents < ActiveRecord::Migration
  def change
  	remove_column :rides, :coordinator_mobile
  	remove_column :events, :coordinator_mobile
  	add_column :rides, :coordinator_mobile, :string
  	add_column :events, :coordinator_mobile, :string
  end
end
