class AddRelationToSpecificationNames < ActiveRecord::Migration[5.1]
  def change
  	add_column :specifications, :specification_name_id, :integer
  end
end
