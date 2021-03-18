class CreateVersionControls < ActiveRecord::Migration[5.1]
  def change
    create_table :version_controls do |t|
      t.integer :user_id
      t.string :current_version
      t.string :latest_version
      t.boolean :allow_update, default: false
      t.boolean :force_update, default: false

      t.timestamps null: false
    end
  end
end
