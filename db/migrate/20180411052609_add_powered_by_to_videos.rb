class AddPoweredByToVideos < ActiveRecord::Migration
  def change
  	 add_column :customer_galleries, :powered_by, :string
  end
end
