class ChangeColumnName < ActiveRecord::Migration
  def change
  	rename_column :tools, :Hersteller, :hersteller
  end
end
