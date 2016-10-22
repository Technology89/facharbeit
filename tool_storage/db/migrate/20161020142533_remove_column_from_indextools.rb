class RemoveColumnFromIndextools < ActiveRecord::Migration
  def change
  	remove_column :indextools, :ausgeliehen
  end
end
