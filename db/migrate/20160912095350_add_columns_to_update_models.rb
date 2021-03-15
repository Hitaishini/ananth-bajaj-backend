class AddColumnsToUpdateModels < ActiveRecord::Migration
  def change
  	add_column :finance_documents, :family, :string
  	remove_column :user_rides, :user_ride_date
  	remove_column :user_events, :user_event_date
  	add_column :profiles, :marriage_anniversary_date, :date, :default => '1900-01-01'
  end
end
