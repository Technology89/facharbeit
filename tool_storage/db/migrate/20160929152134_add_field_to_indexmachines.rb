class AddFieldToIndexmachines < ActiveRecord::Migration
  def change
    add_column :indexmachines, :ausgegeben_von, :string
  end
end
