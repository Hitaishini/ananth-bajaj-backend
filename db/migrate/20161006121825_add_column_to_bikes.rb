class AddColumnToBikes < ActiveRecord::Migration
  def change
  	add_column :bikes, :warranty_url, :string
  end
end
