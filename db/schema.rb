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

ActiveRecord::Schema.define(version: 20160831153106) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "card_sort_candidates", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "age"
    t.jsonb    "describing_tags"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "card_sort_results", force: :cascade do |t|
    t.integer  "card_sort_id"
    t.jsonb    "result"
    t.integer  "card_sort_candidate_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["card_sort_candidate_id"], name: "index_card_sort_results_on_card_sort_candidate_id", using: :btree
    t.index ["card_sort_id"], name: "index_card_sort_results_on_card_sort_id", using: :btree
  end

  create_table "card_sorts", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "code"
    t.integer  "author_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.jsonb    "cards"
    t.index ["author_id"], name: "index_card_sorts_on_author_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "card_sort_results", "card_sort_candidates"
  add_foreign_key "card_sort_results", "card_sorts"
end
