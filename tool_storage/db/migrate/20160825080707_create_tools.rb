class CreateTools < ActiveRecord::Migration
  def change
    create_table :tools do |t|
      t.string :hersteller
      t.string :modell
      t.integer :barcode
      t.integer :lagerbestand
      t.integer :mindestbestand
      t.integer :anzahl_Ersatz

      t.timestamps null: false
    end
  end
end
