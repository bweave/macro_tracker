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

ActiveRecord::Schema[8.0].define(version: 2024_11_16_181340) do
  create_table "entries", force: :cascade do |t|
    t.integer "mealtime", default: 0, null: false
    t.datetime "eaten_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_entries_on_user_id"
  end

  create_table "food_entries", force: :cascade do |t|
    t.integer "food_id", null: false
    t.integer "entry_id", null: false
    t.integer "servings", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["entry_id"], name: "index_food_entries_on_entry_id"
    t.index ["food_id"], name: "index_food_entries_on_food_id"
    t.index ["user_id"], name: "index_food_entries_on_user_id"
  end

  create_table "foods", force: :cascade do |t|
    t.string "name"
    t.decimal "calories"
    t.decimal "carbs"
    t.decimal "protein"
    t.decimal "fat"
    t.decimal "fiber"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_foods_on_user_id"
  end

  create_table "goals", force: :cascade do |t|
    t.string "name"
    t.integer "amount"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_goals_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "entries", "users"
  add_foreign_key "food_entries", "entries"
  add_foreign_key "food_entries", "foods"
  add_foreign_key "food_entries", "users"
  add_foreign_key "foods", "users"
  add_foreign_key "goals", "users"
  add_foreign_key "sessions", "users"
end
