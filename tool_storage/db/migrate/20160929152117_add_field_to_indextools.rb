class AddFieldToIndextools < ActiveRecord::Migration
  def change
    add_column :indextools, :ausgegeben_von, :string
  end
end
