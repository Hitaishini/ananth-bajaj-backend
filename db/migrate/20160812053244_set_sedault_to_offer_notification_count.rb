class SetSedaultToOfferNotificationCount < ActiveRecord::Migration[5.1]
  def change
  	change_column_default(:notification_counts, :offer, 0)
  end
end
