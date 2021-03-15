class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :name
      t.string :mobile
      t.string :email
      t.string :feedback_type
      t.text :comment
      t.integer :rating

      t.timestamps null: false
    end
  end
end
