class AddUserPasswordToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :store_password, :string
  end
end
