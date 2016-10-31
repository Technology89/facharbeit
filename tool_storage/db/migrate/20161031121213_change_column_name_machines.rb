class ChangeColumnNameMachines < ActiveRecord::Migration
  def change
  	rename_column :machines, :ausgeliehen, :ausgegeben
  end
end
