class AddBikeModelToEnquiries < ActiveRecord::Migration[5.1]
  def change
  	add_column :enquiries, :bike, :string 
  end
end
