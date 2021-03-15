class AddFieldToMyDocs < ActiveRecord::Migration
  def change
  	add_column :my_docs, :file_type, :string
  end
end
