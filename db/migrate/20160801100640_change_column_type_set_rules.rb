class ChangeColumnTypeSetRules < ActiveRecord::Migration[5.1]
  def change
  	change_column :set_rules, :days, :text
  end
end
