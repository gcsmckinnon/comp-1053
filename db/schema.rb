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

ActiveRecord::Schema.define(version: 20160924153757) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "card_sort_results", force: :cascade do |t|
    t.integer  "card_sort_id"
    t.jsonb    "result"
    t.jsonb    "card_sort_candidates"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["card_sort_id"], name: "index_card_sort_results_on_card_sort_id", using: :btree
  end

  create_table "card_sorts", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "code"
    t.jsonb    "cards"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "qa_games", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "layout"
  end

  create_table "qa_options", force: :cascade do |t|
    t.integer  "qa_game_id"
    t.string   "option"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["qa_game_id"], name: "index_qa_options_on_qa_game_id", using: :btree
  end

  create_table "qa_question_options", force: :cascade do |t|
    t.integer  "qa_question_id"
    t.integer  "qa_option_id"
    t.integer  "value"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["qa_option_id"], name: "index_qa_question_options_on_qa_option_id", using: :btree
    t.index ["qa_question_id"], name: "index_qa_question_options_on_qa_question_id", using: :btree
  end

  create_table "qa_questions", force: :cascade do |t|
    t.integer  "qa_game_id"
    t.integer  "state"
    t.string   "question"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["qa_game_id"], name: "index_qa_questions_on_qa_game_id", using: :btree
  end

  add_foreign_key "card_sort_results", "card_sorts"
  add_foreign_key "qa_options", "qa_games"
  add_foreign_key "qa_question_options", "qa_options"
  add_foreign_key "qa_question_options", "qa_questions"
  add_foreign_key "qa_questions", "qa_games"
end
