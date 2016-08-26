class ChangeColumnNameAll < ActiveRecord::Migration
  def change
  	rename_column :tools, :Modell, :modell
  	rename_column :tools, :Barcode, :barcode
  	rename_column :tools, :Lagerbestand, :lagerbestand
  	rename_column :tools, :Mindestbestand, :mindestbestand
  	rename_column :tools, :Anzahl_Ersatz, :anzahl_ersatz

  	rename_column :machines, :Hersteller, :hersteller
  	rename_column :machines, :Modell, :modell
  	rename_column :machines, :Barcode, :barcode
  	rename_column :machines, :Ausgeliegen, :ausgeliehen
  	rename_column :machines, :Ausgeliehen_seit, :ausgeliehen_seit
  end
end
