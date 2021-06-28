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

ActiveRecord::Schema.define(version: 2021_06_28_155004) do

  create_table "oauth_access_tokens", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "resource_owner_id"
    t.integer "application_id"
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.index ["resource_owner_id"], name: "fk_rails_ee63f25419"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "relationships", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "user_relationship_id", null: false
    t.string "relationship_type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "fk_rails_a3d77c3b00"
    t.index ["user_relationship_id"], name: "fk_rails_7aed78efb2"
  end

  create_table "time_sleeps", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "date", null: false
    t.datetime "start_time", null: false
    t.datetime "finish_time", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "date"], name: "index_time_sleeps_on_user_id_and_date", unique: true
    t.index ["user_id"], name: "index_time_sleeps_on_user_id"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_users_on_name", unique: true
  end

  add_foreign_key "oauth_access_tokens", "users", column: "resource_owner_id"
  add_foreign_key "relationships", "users"
  add_foreign_key "relationships", "users", column: "user_relationship_id"
  add_foreign_key "time_sleeps", "users"
end
