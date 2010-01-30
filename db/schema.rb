# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100130203527) do

  create_table "comments", :force => true do |t|
    t.integer  "failing_id",   :null => false
    t.integer  "user_id"
    t.text     "text",         :null => false
    t.string   "submitter_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["failing_id"], :name => "index_comments_on_failing_id"

  create_table "emails", :force => true do |t|
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "emails", ["address"], :name => "index_emails_on_address", :unique => true

  create_table "failings", :force => true do |t|
    t.string   "state",        :null => false
    t.integer  "user_id",      :null => false
    t.string   "submitter_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "about"
    t.integer  "submitter_id"
  end

  add_index "failings", ["state"], :name => "index_failings_on_state"
  add_index "failings", ["submitter_id"], :name => "index_failings_on_submitter_id"
  add_index "failings", ["submitter_ip"], :name => "index_failings_on_submitter_ip"
  add_index "failings", ["user_id", "state"], :name => "index_failings_on_user_id_and_state"
  add_index "failings", ["user_id"], :name => "index_failings_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "login",                              :null => false
    t.string   "email",                              :null => false
    t.string   "crypted_password",                   :null => false
    t.string   "password_salt",                      :null => false
    t.string   "persistence_token",                  :null => false
    t.string   "single_access_token",                :null => false
    t.string   "perishable_token",                   :null => false
    t.integer  "login_count",         :default => 0, :null => false
    t.integer  "failed_login_count",  :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.string   "state"
    t.string   "surname"
    t.string   "location"
    t.text     "about"
    t.boolean  "subscribe"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "private"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["login"], :name => "index_users_on_login", :unique => true
  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token", :unique => true
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token", :unique => true
  add_index "users", ["single_access_token"], :name => "index_users_on_single_access_token", :unique => true

  create_table "votes", :force => true do |t|
    t.integer  "failing_id", :null => false
    t.boolean  "agree",      :null => false
    t.string   "voter_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "votes", ["failing_id", "voter_ip"], :name => "index_votes_on_failing_id_and_voter_ip", :unique => true
  add_index "votes", ["failing_id"], :name => "index_votes_on_failing_id"
  add_index "votes", ["user_id"], :name => "index_votes_on_user_id"

end
