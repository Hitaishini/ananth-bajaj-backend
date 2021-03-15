class AddNonBajajDiffToBikes < ActiveRecord::Migration
  def change
  	add_column :bikes, :non_bajaj, :boolean
  end
end
