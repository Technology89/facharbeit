# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160826082143) do

  create_table "employees", force: :cascade do |t|
    t.string   "vorname"
    t.string   "nachname"
    t.integer  "personalnummer"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "indexmachines", force: :cascade do |t|
    t.boolean  "ausgeliehen"
    t.date     "ausgegeben_am"
    t.integer  "employee_id"
    t.integer  "machine_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "indexmachines", ["employee_id"], name: "index_indexmachines_on_employee_id"
  add_index "indexmachines", ["machine_id"], name: "index_indexmachines_on_machine_id"

  create_table "indextools", force: :cascade do |t|
    t.boolean  "ausgeliehen"
    t.date     "ausgegeben_am"
    t.integer  "employee_id"
    t.integer  "tool_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "indextools", ["employee_id"], name: "index_indextools_on_employee_id"
  add_index "indextools", ["tool_id"], name: "index_indextools_on_tool_id"

  create_table "machines", force: :cascade do |t|
    t.string   "hersteller"
    t.string   "modell"
    t.integer  "barcode"
    t.boolean  "ausgeliehen"
    t.date     "ausgegeben_am"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "tools", force: :cascade do |t|
    t.string   "hersteller"
    t.string   "modell"
    t.integer  "barcode"
    t.integer  "lagerbestand"
    t.integer  "mindestbestand"
    t.integer  "anzahl_ersatz"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
