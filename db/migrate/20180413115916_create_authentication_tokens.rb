class CreateAuthenticationTokens < ActiveRecord::Migration
  def change
    create_table :authentication_tokens do |t|
      t.string :body
      t.integer :user_id
      t.datetime :last_used_at
      t.string :ip_address
      t.string :user_agent

      t.timestamps null: false
    end
  end
end
