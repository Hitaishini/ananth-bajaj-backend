class AddImageAndEmailToTestmonials < ActiveRecord::Migration[5.1]
  def change
    add_column :testmonials, :image, :string
    add_column :testmonials, :email, :string
  end
end
