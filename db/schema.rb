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

ActiveRecord::Schema.define(:version => 20140525045505) do

  create_table "allocations", :force => true do |t|
    t.integer  "req_lifetime"
    t.integer  "allotted_lifetime"
    t.integer  "bandwidth_used"
    t.datetime "alloc_at"
    t.datetime "dealloc_at"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "user_id"
    t.string   "protocol"
    t.integer  "ingress_data"
    t.integer  "egress_data"
    t.integer  "total_relay"
    t.integer  "alloc_handle",      :limit => 8
  end

  add_index "allocations", ["user_id"], :name => "index_allocations_on_user_id"

  create_table "customers", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "realm"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "organization"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string   "slug"
  end

  add_index "customers", ["authentication_token"], :name => "index_customers_on_authentication_token", :unique => true
  add_index "customers", ["confirmation_token"], :name => "index_customers_on_confirmation_token", :unique => true
  add_index "customers", ["email"], :name => "index_customers_on_email", :unique => true
  add_index "customers", ["reset_password_token"], :name => "index_customers_on_reset_password_token", :unique => true
  add_index "customers", ["slug"], :name => "index_customers_on_slug"
  add_index "customers", ["unlock_token"], :name => "index_customers_on_unlock_token", :unique => true

  create_table "ephemeral_credentials", :force => true do |t|
    t.string   "username"
    t.string   "secret"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  add_index "ephemeral_credentials", ["user_id"], :name => "index_ephemeral_credentials_on_user_id"
  add_index "ephemeral_credentials", ["username"], :name => "index_ephemeral_credentials_on_username", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                :default => "", :null => false
    t.string   "encrypted_password",   :default => "", :null => false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.integer  "customer_id"
    t.integer  "max_allocs"
    t.integer  "max_concur_allocs"
    t.integer  "def_lifetime"
    t.integer  "max_bandwidth"
    t.string   "turn_secret"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "allocs",               :default => 0
    t.integer  "active_allocs",        :default => 0
    t.integer  "bandwidth_used",       :default => 0
    t.string   "turn_username"
    t.string   "slug"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["slug"], :name => "index_users_on_slug"
  add_index "users", ["turn_username"], :name => "index_users_on_turn_username"

end
