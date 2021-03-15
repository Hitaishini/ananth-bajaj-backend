class ChangeColumForAccessoryEnquiry < ActiveRecord::Migration
  def change
  	change_column :accessory_enquiries, :accessory_id, :text
  end
end
