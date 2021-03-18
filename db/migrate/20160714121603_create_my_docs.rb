class CreateMyDocs < ActiveRecord::Migration[5.1]
  def change
    create_table :my_docs do |t|
      t.string :image
      t.string :document_name
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
