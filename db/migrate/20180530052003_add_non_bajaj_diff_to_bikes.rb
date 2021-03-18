class AddNonBajajDiffToBikes < ActiveRecord::Migration[5.1]
  def change
  	add_column :bikes, :non_bajaj, :boolean
  end
end
