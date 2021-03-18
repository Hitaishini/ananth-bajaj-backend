class AddLocationToSetMails < ActiveRecord::Migration[5.1]
  def change
    add_column :set_mails, :location, :string
  end
end
