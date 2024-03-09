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

ActiveRecord::Schema[7.1].define(version: 2024_03_08_190318) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookmarks", force: :cascade do |t|
    t.string "href"
    t.string "desc"
    t.datetime "add_date"
    t.datetime "last_modified"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "pathx_id"
    t.index ["pathx_id"], name: "index_bookmarks_on_pathx_id"
  end

  create_table "categories", force: :cascade do |t|
    t.integer "parent_id"
    t.integer "child_id"
    t.integer "generation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "choiceproposals", force: :cascade do |t|
    t.string "content"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hierxes", force: :cascade do |t|
    t.integer "parent_id"
    t.integer "child_id"
    t.integer "generation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["child_id"], name: "index_hierxes_on_child_id"
    t.index ["generation"], name: "index_hierxes_on_generation"
    t.index ["parent_id"], name: "index_hierxes_on_parent_id"
  end

  create_table "pages", force: :cascade do |t|
    t.string "name"
    t.string "string"
    t.string "description"
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pathxes", force: :cascade do |t|
    t.integer "idx"
    t.string "path"
    t.string "last_item"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prevotes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "proposer_id", null: false
    t.index ["proposer_id"], name: "index_prevotes_on_proposer_id"
  end

  create_table "proposers", force: :cascade do |t|
    t.string "name"
    t.string "session"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "prevote_id", null: false
    t.bigint "proposer_id", null: false
    t.index ["prevote_id"], name: "index_proposers_on_prevote_id"
    t.index ["proposer_id"], name: "index_proposers_on_proposer_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "image_file_name"
    t.string "email"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ys", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
