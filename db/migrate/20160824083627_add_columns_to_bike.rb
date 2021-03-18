class AddColumnsToBike < ActiveRecord::Migration[5.1]
  def change
  	add_column :bikes, :brand, :string
  	add_column :dealers, :mobile, :string
  	add_column :enquiries, :dealer_location, :string
  end
end
