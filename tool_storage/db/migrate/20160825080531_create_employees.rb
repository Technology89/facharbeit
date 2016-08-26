class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :Vorname
      t.string :Nachname
      t.integer :Personalnummer

      t.timestamps null: false
    end
  end
end
