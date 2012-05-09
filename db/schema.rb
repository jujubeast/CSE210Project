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

ActiveRecord::Schema.define(:version => 0) do

  create_table "categories", :force => true do |t|
    t.string   "category",   :limit => 64
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lists", :force => true do |t|
    t.string   "name",       :limit => 45
    t.boolean  "private",                  :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lists_stores", :force => true do |t|
    t.integer  "store_id",   :null => false
    t.integer  "list_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lists_stores", ["list_id"], :name => "fk_table3_list1"
  add_index "lists_stores", ["store_id", "list_id"], :name => "idstore_idlist", :unique => true
  add_index "lists_stores", ["store_id"], :name => "fk_table3_store1"

  create_table "lists_users", :force => true do |t|
    t.integer  "user_id",                       :null => false
    t.integer  "list_id",                       :null => false
    t.boolean  "owner",      :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lists_users", ["list_id"], :name => "fk_user_list_list1"
  add_index "lists_users", ["user_id", "list_id"], :name => "iduser_idlist", :unique => true
  add_index "lists_users", ["user_id"], :name => "fk_table2_user1"

  create_table "stores", :force => true do |t|
    t.string   "name",        :limit => 256, :null => false
    t.text     "detail_info"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stores_tags_users", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "store_id",   :null => false
    t.integer  "tag_id",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stores_tags_users", ["store_id"], :name => "fk_user_store_tags_store1"
  add_index "stores_tags_users", ["tag_id"], :name => "fk_user_store_tags_tags1"
  add_index "stores_tags_users", ["user_id", "store_id", "tag_id"], :name => "iduser_idstore_idtags", :unique => true
  add_index "stores_tags_users", ["user_id"], :name => "fk_user_store_tags_user1"

  create_table "stores_users", :force => true do |t|
    t.integer  "user_id",                   :null => false
    t.integer  "store_id",                  :null => false
    t.integer  "visited",    :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stores_users", ["store_id"], :name => "fk_user_store_store1"
  add_index "stores_users", ["user_id", "store_id"], :name => "iduser_idstore", :unique => true
  add_index "stores_users", ["user_id"], :name => "fk_user_store_user"

  create_table "tags", :force => true do |t|
    t.string   "name",        :limit => 64, :null => false
    t.integer  "category_id",               :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["category_id"], :name => "fk_tags_Category1"
  add_index "tags", ["category_id"], :name => "tags_category", :unique => true

  create_table "users", :force => true do |t|
    t.integer  "fb_id", :null => true
    t.string   "picture_link", :null => true
    t.string   "email", :null => false
    t.string   "first_name", :null => false
    t.string   "last_name",  :null => false
    t.string   "password", :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
