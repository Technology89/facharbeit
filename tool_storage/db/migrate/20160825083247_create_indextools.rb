class CreateIndextools < ActiveRecord::Migration
  def change
    create_table :indextools do |t|
      t.date :ausgegeben_am
      t.string :ausgegeben_von
      t.references :employee, index: true, foreign_key: true
      t.references :tool, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
