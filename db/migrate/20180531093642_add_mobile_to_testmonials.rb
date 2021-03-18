class AddMobileToTestmonials < ActiveRecord::Migration[5.1]
  def change
  	add_column :testmonials, :mobile, :string
  end
end
