class CreateInsuranceRenewals < ActiveRecord::Migration[5.1]
  def change
    create_table :insurance_renewals do |t|
      t.string :name
      t.string :email
      t.string :mobile
      t.string :address
      t.string :bike
      t.date   :purchase_date
      t.integer :kms
      t.string :registration_number
      t.string :insurance_company
      t.string :policy_number
      t.string :expiry_date
      t.string :status, default: "Not Followed-Up"

      t.timestamps null: false
    end
  end
end
