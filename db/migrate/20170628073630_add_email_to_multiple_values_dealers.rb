class AddEmailToMultipleValuesDealers < ActiveRecord::Migration
  def change
  	change_column :dealers, :email, :text
  end
end
