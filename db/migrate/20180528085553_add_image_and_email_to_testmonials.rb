class AddImageAndEmailToTestmonials < ActiveRecord::Migration
  def change
    add_column :testmonials, :image, :string
    add_column :testmonials, :email, :string
  end
end
