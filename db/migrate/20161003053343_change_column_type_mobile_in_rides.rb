class ChangeColumnTypeMobileInRides < ActiveRecord::Migration
  def change
  	change_column :rides, :coordinator_mobile, :string
  	change_column :events, :coordinator_mobile, :string
  end
end
