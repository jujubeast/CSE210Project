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

ActiveRecord::Schema.define(:version => 20120605231756) do

  create_table "categories", :force => true do |t|
    t.string   "category",   :limit => 128, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_tags", :force => true do |t|
    t.integer  "category_id", :null => false
    t.integer  "tag_id",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "list_stores", :force => true do |t|
    t.integer  "store_id",   :null => false
    t.integer  "list_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "list_users", :force => true do |t|
    t.integer  "user_id",                   :null => false
    t.integer  "list_id",                   :null => false
    t.integer  "privilege",  :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lists", :force => true do |t|
    t.string   "name",       :limit => 128, :null => false
    t.integer  "privacy"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_tag_users", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "store_id",   :null => false
    t.integer  "tag_id",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "store_tag_users", ["store_id"], :name => "fk_user_store_tag_store1"
  add_index "store_tag_users", ["tag_id"], :name => "fk_user_store_tag_tag1"
  add_index "store_tag_users", ["user_id", "store_id", "tag_id"], :name => "iduser_idstore_idtag", :unique => true
  add_index "store_tag_users", ["user_id"], :name => "fk_user_store_tag_user1"

  create_table "store_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "store_id"
    t.integer  "been_there", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stores", :force => true do |t|
    t.string   "name",        :limit => 128,  :null => false
    t.string   "detail_info", :limit => 1024
    t.string   "pic",         :limit => 256
    t.string   "street_1",    :limit => 128,  :null => false
    t.string   "street_2",    :limit => 128
    t.string   "city",        :limit => 64,   :null => false
    t.string   "state",       :limit => 32,   :null => false
    t.string   "zipcode",     :limit => 16,   :null => false
    t.string   "telephone",   :limit => 16
    t.string   "website",     :limit => 256
    t.string   "hours",       :limit => 128
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stores_tags", :force => true do |t|
    t.integer  "store_id",   :null => false
    t.integer  "tag_id",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.string   "name",        :limit => 128, :null => false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
  end

  create_table "users", :force => true do |t|
    t.string   "fb_id",        :limit => 64,  :null => false
    t.string   "email",        :limit => 128, :null => false
    t.string   "first_name",   :limit => 128, :null => false
    t.string   "last_name",    :limit => 128, :null => false
    t.string   "picture_link", :limit => 256
    t.string   "password",     :limit => 64
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
