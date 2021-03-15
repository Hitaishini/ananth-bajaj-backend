class AddColumnServiceScheduleBikes < ActiveRecord::Migration
  def change
  	add_column :bikes, :service_schedule_url, :string
  end
end
