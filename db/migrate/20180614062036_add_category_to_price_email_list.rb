class AddCategoryToPriceEmailList < ActiveRecord::Migration[5.1]
  def change
  	add_column :email_price_lists, :category, :string 
  end
end
