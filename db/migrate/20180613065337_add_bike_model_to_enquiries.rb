class AddBikeModelToEnquiries < ActiveRecord::Migration
  def change
  	add_column :enquiries, :bike, :string 
  end
end
