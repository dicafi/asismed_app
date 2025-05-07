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

ActiveRecord::Schema[8.0].define(version: 2025_05_07_070550) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pgcrypto"

  create_table "appointments", force: :cascade do |t|
    t.date "date"
    t.time "time"
    t.bigint "patient_id"
    t.text "details"
    t.bigint "medical_note_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "doctor_id", default: -> { "gen_random_uuid()" }
    t.index ["doctor_id"], name: "index_appointments_on_doctor_id"
    t.index ["medical_note_id"], name: "index_appointments_on_medical_note_id"
    t.index ["patient_id"], name: "index_appointments_on_patient_id"
  end

  create_table "education_levels", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "insurers", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "marital_statuses", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "medical_notes", force: :cascade do |t|
    t.text "ta"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "patients", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "last_name", null: false
    t.string "second_last_name", null: false
    t.date "birth_date", null: false
    t.string "phone_number", null: false
    t.string "email", null: false
    t.integer "gender", null: false
    t.integer "marital_status_id"
    t.string "occupation"
    t.integer "education_level_id"
    t.string "postal_code"
    t.string "state"
    t.string "municipality"
    t.string "neighborhood"
    t.string "address"
    t.string "origin"
    t.string "religion"
    t.integer "interrogation"
    t.integer "insurer_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "profile"
    t.string "last_name"
    t.string "second_last_name"
    t.string "first_name"
    t.string "signature"
    t.boolean "active", default: true
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "session_token"
    t.date "date_of_birth"
    t.string "office"
    t.index ["session_token"], name: "index_users_on_session_token", unique: true
  end

  add_foreign_key "appointments", "medical_notes"
  add_foreign_key "appointments", "patients"
  add_foreign_key "appointments", "users", column: "doctor_id"
  add_foreign_key "patients", "education_levels"
  add_foreign_key "patients", "insurers"
  add_foreign_key "patients", "marital_statuses"
end
