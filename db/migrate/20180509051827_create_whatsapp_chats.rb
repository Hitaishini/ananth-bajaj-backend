class CreateWhatsappChats < ActiveRecord::Migration
  def change
    create_table :whatsapp_chats do |t|
      t.string :contact_number
      t.text :default_message
      t.string :label

      t.timestamps null: false
    end
  end
end
