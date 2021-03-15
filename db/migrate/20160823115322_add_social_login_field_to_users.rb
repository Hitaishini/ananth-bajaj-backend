class AddSocialLoginFieldToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :social_login, :boolean, default: false
  end
end
