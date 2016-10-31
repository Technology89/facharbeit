class CreateMachines < ActiveRecord::Migration
  def change
    create_table :machines do |t|
      t.string :hersteller
      t.string :modell
      t.integer :barcode
      t.boolean :ausgegeben

      t.timestamps null: false
    end
  end
end
