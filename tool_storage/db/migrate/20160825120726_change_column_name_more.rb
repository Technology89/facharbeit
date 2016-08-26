class ChangeColumnNameMore < ActiveRecord::Migration
  def change
  	rename_column :machines, :ausgeliehen_seit, :ausgegeben_am
  	rename_column :indexmachines, :ausgeliehen_am, :ausgegeben_am
  	rename_column :indextools, :ausgeliehen_am, :ausgegeben_am
  end
end
