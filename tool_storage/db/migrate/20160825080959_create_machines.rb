class CreateMachines < ActiveRecord::Migration
  def change
    create_table :machines do |t|
      t.string :Hersteller
      t.string :Modell
      t.integer :Barcode
      t.boolean :Ausgeliegen
      t.date :Ausgeliehen_seit

      t.timestamps null: false
    end
  end
end
