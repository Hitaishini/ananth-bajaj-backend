class CreateCareers < ActiveRecord::Migration
  def change
    create_table :careers do |t|
      t.string :name
      t.string :email
      t.string :mobile
      t.integer :experience_years
      t.integer :experience_months
      t.string :current_company
      t.string :cover_letter
      t.string :cv_file
      t.integer :job_id

      t.timestamps null: false
    end
  end
end
