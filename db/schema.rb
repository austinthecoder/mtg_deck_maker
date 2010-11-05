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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101104021437) do

  create_table "cards", :force => true do |t|
    t.string   "name"
    t.string   "colors"
    t.string   "mana_cost"
    t.string   "rarity"
    t.string   "type_line"
    t.text     "rules_text"
    t.integer  "mtg_set_id"
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "power"
    t.string   "toughness"
    t.integer  "loyalty"
  end

  create_table "formats", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "formats_mtg_sets", :id => false, :force => true do |t|
    t.integer "format_id"
    t.integer "mtg_set_id"
  end

  create_table "mtg_sets", :force => true do |t|
    t.string   "name"
    t.datetime "released_at"
    t.integer  "num_cards"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
  end

end
