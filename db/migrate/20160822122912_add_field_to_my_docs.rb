class AddFieldToMyDocs < ActiveRecord::Migration[5.1]
  def change
  	add_column :my_docs, :file_type, :string
  end
end
