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

ActiveRecord::Schema[7.0].define(version: 2024_11_20_080325) do
  create_table "active_storage_attachments", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb3", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "comment_facilities", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "comment_id", null: false
    t.bigint "facility_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comment_id"], name: "index_comment_facilities_on_comment_id"
    t.index ["facility_id"], name: "index_comment_facilities_on_facility_id"
  end

  create_table "comments", charset: "utf8mb3", force: :cascade do |t|
    t.text "content", null: false
    t.bigint "user_id", null: false
    t.bigint "park_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "google_place_id"
    t.boolean "toilet", default: false
    t.boolean "diaper_changing_station", default: false
    t.boolean "vending_machine", default: false
    t.boolean "shop", default: false
    t.boolean "parking", default: false
    t.boolean "slide", default: false
    t.boolean "swing", default: false
    t.index ["park_id"], name: "index_comments_on_park_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "facilities", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "park_id", null: false
    t.boolean "toilet", default: false, null: false
    t.boolean "diaper_changing_station", default: false, null: false
    t.boolean "vending_machine", default: false, null: false
    t.boolean "shop", default: false, null: false
    t.boolean "parking", default: false, null: false
    t.boolean "slide", default: false, null: false
    t.boolean "swing", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["park_id"], name: "index_facilities_on_park_id"
  end

  create_table "parks", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.string "address"
    t.text "description"
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.string "place_id"
    t.string "phone_number"
    t.string "website"
    t.float "rating"
    t.integer "user_ratings_total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "google_place_id"
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "nickname", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comment_facilities", "comments"
  add_foreign_key "comment_facilities", "facilities"
  add_foreign_key "comments", "parks"
  add_foreign_key "comments", "users"
  add_foreign_key "facilities", "parks"
end
