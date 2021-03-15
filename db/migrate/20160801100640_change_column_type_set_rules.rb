class ChangeColumnTypeSetRules < ActiveRecord::Migration
  def change
  	change_column :set_rules, :days, :text
  end
end
