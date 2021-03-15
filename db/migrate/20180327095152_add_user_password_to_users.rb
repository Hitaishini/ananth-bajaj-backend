class AddUserPasswordToUsers < ActiveRecord::Migration
  def change
    add_column :users, :store_password, :string
  end
end
