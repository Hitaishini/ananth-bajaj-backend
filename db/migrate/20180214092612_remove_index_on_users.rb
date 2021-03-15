class RemoveIndexOnUsers < ActiveRecord::Migration
  def change
  	remove_index :users, column: :email, unique: true
  end
end
