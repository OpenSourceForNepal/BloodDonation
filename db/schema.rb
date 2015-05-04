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

ActiveRecord::Schema.define(version: 20150503081226) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blood_types", force: :cascade do |t|
    t.string   "blood_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blood_types_hospitals", force: :cascade do |t|
    t.integer  "hospital_id"
    t.integer  "blood_type_id"
    t.datetime "expires_on"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "blood_types_hospitals", ["blood_type_id"], name: "index_blood_types_hospitals_on_blood_type_id", using: :btree
  add_index "blood_types_hospitals", ["hospital_id"], name: "index_blood_types_hospitals_on_hospital_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "donors", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "cell_phone"
    t.string   "email"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.string   "country",        default: "Nepal"
    t.float    "lat"
    t.float    "long"
    t.integer  "commute_radius", default: 5
    t.string   "blood_type"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "hospitals", force: :cascade do |t|
    t.string   "name"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.string   "country",              default: "Nepal"
    t.string   "lat"
    t.string   "long"
    t.string   "contact_person_name"
    t.string   "contact_person_email"
    t.string   "contact_person_phone"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

end
