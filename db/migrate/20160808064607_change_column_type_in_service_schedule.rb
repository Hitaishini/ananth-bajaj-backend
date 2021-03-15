class ChangeColumnTypeInServiceSchedule < ActiveRecord::Migration
  def change
  	change_column :service_schedules, :months, 'integer USING CAST(months AS integer)'
  end
end
