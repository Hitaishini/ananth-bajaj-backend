class AddRelationToSpecificationNames < ActiveRecord::Migration
  def change
  	add_column :specifications, :specification_name_id, :integer
  end
end
