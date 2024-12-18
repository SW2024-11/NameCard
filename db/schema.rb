# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_12_18_080221) do
  create_table "cards", force: :cascade do |t|
    t.string "company"
    t.string "name"
    t.string "position"
    t.string "license"
    t.string "mail"
    t.string "tell"
    t.string "company_adress"
    t.binary "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "my_companies", force: :cascade do |t|
    t.string "string"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "my_names", force: :cascade do |t|
    t.string "string"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "passes", force: :cascade do |t|
    t.string "string"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "my_company"
    t.string "my_name"
    t.string "pass"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
