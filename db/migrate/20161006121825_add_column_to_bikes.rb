class AddColumnToBikes < ActiveRecord::Migration[5.1]
  def change
  	add_column :bikes, :warranty_url, :string
  end
end
