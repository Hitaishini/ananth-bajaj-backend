class AddTokensToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ios_token, :string
    add_column :users, :android_token, :string
  end
end
