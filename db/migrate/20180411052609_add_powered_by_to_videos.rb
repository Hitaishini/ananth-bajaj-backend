class AddPoweredByToVideos < ActiveRecord::Migration[5.1]
  def change
  	 add_column :customer_galleries, :powered_by, :string
  end
end
