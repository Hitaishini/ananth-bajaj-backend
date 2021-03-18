class ChangeColumnTypeInServiceSchedule < ActiveRecord::Migration[5.1]
  def change
  	change_column :service_schedules, :months, 'integer USING CAST(months AS integer)'
  end
end
