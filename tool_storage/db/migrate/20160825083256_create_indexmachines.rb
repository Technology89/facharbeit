class CreateIndexmachines < ActiveRecord::Migration
  def change
    create_table :indexmachines do |t|
      t.boolean :ausgeliehen
      t.date :ausgeliehen_am
      t.string :ausgegeben_von
      t.references :employee, index: true, foreign_key: true
      t.references :machine, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
