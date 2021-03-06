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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120830234420) do

  create_table "addresses", :force => true do |t|
    t.string   "url"
    t.string   "description"
    t.string   "domain"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "discipline_id"
    t.string   "normalized_url"
    t.string   "normalized_domain"
  end

  add_index "addresses", ["discipline_id"], :name => "index_addresses_on_discipline_id"
  add_index "addresses", ["domain"], :name => "index_addresses_on_domain"
  add_index "addresses", ["url", "discipline_id"], :name => "index_addresses_on_url_and_discipline_id", :unique => true

  create_table "disciplines", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "sector_id"
  end

  add_index "disciplines", ["name"], :name => "index_disciplines_on_name", :unique => true
  add_index "disciplines", ["sector_id"], :name => "index_disciplines_on_sector_id"

  create_table "sectors", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sectors", ["name"], :name => "index_sectors_on_name", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "zones", :force => true do |t|
    t.string   "suffix"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "zones", ["suffix"], :name => "index_zones_on_suffix", :unique => true

end
