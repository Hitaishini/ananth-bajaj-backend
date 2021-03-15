class AddFiledToProfiles < ActiveRecord::Migration
  def change
		add_column :profiles, :notifiable_offers, :boolean, default: true
	  	add_column :profiles, :notifiable_events, :boolean, default: true
	  	add_column :profiles, :notifiable_bookings, :boolean, default: true
	  	add_column :profiles, :notifiable_accessories, :boolean, default: true
  end
end
