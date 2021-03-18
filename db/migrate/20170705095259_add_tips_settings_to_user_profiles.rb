class AddTipsSettingsToUserProfiles < ActiveRecord::Migration[5.1]
  def change
  	add_column :profiles, :notifiable_tips, :boolean, default: true
  end
end
