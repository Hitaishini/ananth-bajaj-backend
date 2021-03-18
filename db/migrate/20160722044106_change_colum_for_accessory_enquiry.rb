class ChangeColumForAccessoryEnquiry < ActiveRecord::Migration[5.1]
  def change
  	change_column :accessory_enquiries, :accessory_id, :text
  end
end
