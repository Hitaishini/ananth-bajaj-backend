class CreateFinanceDocuments < ActiveRecord::Migration
  def change
    create_table :finance_documents do |t|
      t.string :category
      t.text :document_list

      t.timestamps null: false
    end
  end
end
