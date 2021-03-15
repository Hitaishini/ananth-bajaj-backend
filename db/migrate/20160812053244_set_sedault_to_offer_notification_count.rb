class SetSedaultToOfferNotificationCount < ActiveRecord::Migration
  def change
  	change_column_default(:notification_counts, :offer, 0)
  end
end
