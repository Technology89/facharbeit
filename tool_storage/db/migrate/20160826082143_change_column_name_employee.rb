class ChangeColumnNameEmployee < ActiveRecord::Migration
  def change
  	rename_column :employees, :Vorname, :vorname
  	rename_column :employees, :Nachname, :nachname
  	rename_column :employees, :Personalnummer, :personalnummer
  end
end
