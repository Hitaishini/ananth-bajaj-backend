class AddLocationToSetMails < ActiveRecord::Migration
  def change
    add_column :set_mails, :location, :string
  end
end
