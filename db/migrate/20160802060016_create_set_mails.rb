class CreateSetMails < ActiveRecord::Migration
  def change
    create_table :set_mails do |t|
      t.string :email
      t.string :category

      t.timestamps null: false
    end
  end
end
