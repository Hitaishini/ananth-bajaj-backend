class AddFileValidateFieldsToServiceHistories < ActiveRecord::Migration[5.1]
  def change
  	add_column :service_histories, :document_name, :string
  	add_column :service_histories, :file_type, :string
  end
end
