class CreateIndextools < ActiveRecord::Migration
  def change
    create_table :indextools do |t|
      t.boolean :ausgeliehen
      t.date :ausgeliehen_am
      t.references :employee, index: true, foreign_key: true
      t.references :tool, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
