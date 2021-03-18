class AddEmailToMultipleValuesDealers < ActiveRecord::Migration[5.1]
  def change
  	change_column :dealers, :email, :text
  end
end
