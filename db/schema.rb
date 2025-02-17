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

ActiveRecord::Schema[8.0].define(version: 2024_12_27_164753) do
  create_table "assignments", force: :cascade do |t|
    t.string "public_task_code"
    t.string "private_task_code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "wrong_translations"
    t.string "original_language"
    t.string "translated_language"
  end

  create_table "words", force: :cascade do |t|
    t.integer "assignment_id", null: false
    t.string "original_text"
    t.string "translated_text"
    t.string "original_text_error1"
    t.string "original_text_error2"
    t.string "original_text_error3"
    t.string "translated_text_error1"
    t.string "translated_text_error2"
    t.string "translated_text_error3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignment_id"], name: "index_words_on_assignment_id"
  end

  add_foreign_key "words", "assignments"
end
