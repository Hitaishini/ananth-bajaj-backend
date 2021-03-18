class CreateFinanceDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :finance_documents do |t|
      t.string :category
      t.text :document_list

      t.timestamps null: false
    end
  end
end
