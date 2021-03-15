class AddMobileToTestmonials < ActiveRecord::Migration
  def change
  	add_column :testmonials, :mobile, :string
  end
end
