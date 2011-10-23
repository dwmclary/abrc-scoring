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

ActiveRecord::Schema.define(:version => 20110930073736) do

  create_table "league_members", :force => true do |t|
    t.integer  "league_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "league_scores", :force => true do |t|
    t.integer  "league_id",  :null => false
    t.integer  "user_id",    :null => false
    t.integer  "score",      :null => false
    t.integer  "exes"
    t.string   "end_scores"
    t.date     "shot_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leagues", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "distance"
    t.date     "start_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "round_ends", :force => true do |t|
    t.integer  "user_id",                    :null => false
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
    t.integer  "user_id",                        :null => false
    t.integer  "total_score"
    t.integer  "total_bullseye"
    t.integer  "end_count",      :default => 10, :null => false
    t.integer  "arrow_count",    :default => 3,  :null => false
    t.date     "shot_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "league_id"
    t.integer  "arrow_score",    :default => 10
    t.integer  "tournament_id"
  end

  create_table "tournament_members", :force => true do |t|
    t.integer  "tournament_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tournament_scores", :force => true do |t|
    t.integer  "tournament_id", :null => false
    t.integer  "user_id",       :null => false
    t.integer  "score",         :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tournaments", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "distance",   :null => false
    t.date     "shot_at",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "best_score",                            :default => 0
    t.decimal  "average_score"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                                 :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
