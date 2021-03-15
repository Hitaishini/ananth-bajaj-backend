class AddColumnToUserRides < ActiveRecord::Migration
  def change
  	 add_column :user_rides, :perticipate_ride, :string
  	 add_column :user_events, :perticipate_event, :string
  end
end
