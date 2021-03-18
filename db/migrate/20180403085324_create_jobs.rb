class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :required_skills
      t.string :location
      t.string :technologies_required
      t.string :experience_required
      t.string :interview
      t.string :note
      t.string :notice_period

      t.timestamps null: false

      t.timestamps null: false
    end
  end
end
