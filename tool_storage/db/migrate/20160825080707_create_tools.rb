class CreateTools < ActiveRecord::Migration
  def change
    create_table :tools do |t|
      t.string :Hersteller
      t.string :Modell
      t.integer :Barcode
      t.integer :Lagerbestand
      t.integer :Mindestbestand
      t.integer :Anzahl_Ersatz

      t.timestamps null: false
    end
  end
end
