class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :vorname
      t.string :nachname
      t.integer :personalnummer

      t.timestamps null: false
    end
  end
end
