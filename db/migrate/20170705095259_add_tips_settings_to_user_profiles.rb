class AddTipsSettingsToUserProfiles < ActiveRecord::Migration
  def change
  	add_column :profiles, :notifiable_tips, :boolean, default: true
  end
end
