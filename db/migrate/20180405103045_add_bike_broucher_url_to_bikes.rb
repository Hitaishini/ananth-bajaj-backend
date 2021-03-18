class AddBikeBroucherUrlToBikes < ActiveRecord::Migration[5.1]
  def change
  	 add_column :bikes, :bike_brochure_url, :string
  	 add_column :banners, :display_order, :integer
  end
end
