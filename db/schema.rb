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

ActiveRecord::Schema.define(:version => 20110422183306) do

  create_table "league_members", :force => true do |t|
    t.integer  "league_id"
    t.integer  "shooter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leagues", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "distance"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "round_ends", :force => true do |t|
    t.integer  "shooter_id",                 :null => false
    t.integer  "round_id",                   :null => false
    t.integer  "end_count",                  :null => false
    t.integer  "arrow_count", :default => 3, :null => false
    t.integer  "x_count",     :default => 0, :null => false
    t.integer  "end_score",   :default => 0, :null => false
    t.string   "scores"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rounds", :force => true do |t|
    t.integer  "shooter_id",                     :null => false
    t.integer  "total_score"
    t.integer  "total_bullseye"
    t.integer  "end_count",      :default => 10, :null => false
    t.integer  "arrow_count",    :default => 3,  :null => false
    t.date     "shot_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "league_id"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "shooters", :force => true do |t|
    t.string   "name",                           :null => false
    t.integer  "best_score",      :default => 0
    t.decimal  "average_score"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "hashed_password"
    t.string   "salt"
  end

end
