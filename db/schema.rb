# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_07_20_132447) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.integer "resource_id"
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "booking_infos", force: :cascade do |t|
    t.date "booking_date"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "theater_id"
    t.integer "screen_id"
    t.integer "show_id"
    t.integer "no_of_tickets"
    t.time "booking_time"
    t.index ["screen_id"], name: "index_booking_infos_on_screen_id"
    t.index ["show_id"], name: "index_booking_infos_on_show_id"
    t.index ["theater_id"], name: "index_booking_infos_on_theater_id"
    t.index ["user_id"], name: "index_booking_infos_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating"
    t.text "feedback"
    t.integer "user_id", null: false
    t.integer "show_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "theater_id"
    t.index ["show_id"], name: "index_reviews_on_show_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "screens", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status"
    t.integer "theater_id"
    t.string "screen_name"
    t.integer "total_seats"
    t.index ["theater_id"], name: "index_screens_on_theater_id"
  end

  create_table "show_slots", force: :cascade do |t|
    t.integer "show_id"
    t.integer "slot_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["show_id"], name: "index_show_slots_on_show_id"
    t.index ["slot_id"], name: "index_show_slots_on_slot_id"
  end

  create_table "show_times", force: :cascade do |t|
    t.time "time"
    t.integer "show_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "remaining_seats"
    t.index ["show_id"], name: "index_show_times_on_show_id"
  end

  create_table "shows", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "recurring"
    t.date "start_date"
    t.date "end_date"
    t.time "duration"
    t.integer "theater_id"
    t.integer "screen_id"
  end

  create_table "slots", force: :cascade do |t|
    t.integer "screen_id", null: false
    t.time "start_time"
    t.time "end_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["screen_id"], name: "index_slots_on_screen_id"
  end

  create_table "theater_users", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "theater_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["theater_id"], name: "index_theater_users_on_theater_id"
    t.index ["user_id"], name: "index_theater_users_on_user_id"
  end

  create_table "theaters", force: :cascade do |t|
    t.string "name"
    t.string "addres"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "booking_infos", "screens"
  add_foreign_key "booking_infos", "shows"
  add_foreign_key "booking_infos", "theaters"
  add_foreign_key "booking_infos", "users"
  add_foreign_key "reviews", "shows"
  add_foreign_key "reviews", "users"
  add_foreign_key "screens", "theaters"
  add_foreign_key "show_slots", "shows"
  add_foreign_key "show_slots", "slots"
  add_foreign_key "show_times", "shows"
  add_foreign_key "slots", "screens"
  add_foreign_key "theater_users", "theaters"
  add_foreign_key "theater_users", "users"
end
