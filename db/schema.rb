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
    t.string   "category",   :limit => 45
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lists", :force => true do |t|
    t.string   "name",       :limit => 45
    t.integer  "privacy"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "list_stores", :force => true do |t|
    t.integer  "store_id",   :null => false
    t.integer  "list_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "list_stores", ["list_id"], :name => "fk_table3_list1"
  add_index "list_stores", ["store_id", "list_id"], :name => "idstore_idlist", :unique => true
  add_index "list_stores", ["store_id"], :name => "fk_table3_store1"

  create_table "list_users", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "list_id",    :null => false
    t.integer  "privilege"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "list_users", ["list_id"], :name => "fk_user_list_list1"
  add_index "list_users", ["user_id", "list_id"], :name => "iduser_idlist", :unique => true
  add_index "list_users", ["user_id"], :name => "fk_table2_user1"

  create_table "stores", :force => true do |t|
    t.string   "name",        :limit => 45
    t.string   "detail_info", :limit => 45
    t.string   "pic",         :limit => 45
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
    t.integer  "user_id",    :null => false
    t.integer  "store_id",   :null => false
    t.integer  "beenThere"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "store_users", ["store_id"], :name => "fk_user_store_store1"
  add_index "store_users", ["user_id", "store_id"], :name => "iduser_idstore", :unique => true
  add_index "store_users", ["user_id"], :name => "fk_user_store_user"

  create_table "tags", :force => true do |t|
    t.string   "name",        :limit => 45, :null => false
    t.integer  "category_id",               :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["category_id"], :name => "fk_tags_Category1"
  add_index "tags", ["category_id"], :name => "tags_category", :unique => true

  create_table "users", :force => true do |t|
    t.string   "fb_id",      :limit => 45
    t.string   "email",       :limit => 128
    t.string   "first_name"  
    t.string   "last_name"
    t.string   "picture_link"
    t.string   "password",     :limit => 64 
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
