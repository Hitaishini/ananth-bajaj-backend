class AddColumnServiceScheduleBikes < ActiveRecord::Migration[5.1]
  def change
  	add_column :bikes, :service_schedule_url, :string
  end
end
