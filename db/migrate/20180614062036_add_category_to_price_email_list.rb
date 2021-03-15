class AddCategoryToPriceEmailList < ActiveRecord::Migration
  def change
  	add_column :email_price_lists, :category, :string 
  end
end
