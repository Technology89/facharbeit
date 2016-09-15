class RemoveColumnsFromMachines < ActiveRecord::Migration
  def change
  	remove_column :machines, :ausgegeben_am
  end
end
