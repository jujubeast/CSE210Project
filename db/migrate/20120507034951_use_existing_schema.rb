class UseExistingSchema < ActiveRecord::Migration
  ActiveRecord::Schema.define(:version => 0) do

  create_table "categories", :force => true do |t|
    t.string   "category",   :limit => 45
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lists", :force => true do |t|
    t.string   "name",       :limit => 45
    t.boolean  "privacy"
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
    t.integer  "user_id",    :null => false
    t.integer  "list_id",    :null => false
    t.boolean  "owner"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lists_users", ["list_id"], :name => "fk_user_list_list1"
  add_index "lists_users", ["user_id", "list_id"], :name => "iduser_idlist", :unique => true
  add_index "lists_users", ["user_id"], :name => "fk_table2_user1"

  create_table "stores", :force => true do |t|
    t.string   "name",        :limit => 45
    t.string   "detail_info", :limit => 45
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
    t.integer  "user_id",    :null => false
    t.integer  "store_id",   :null => false
    t.integer  "beenThere"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stores_users", ["store_id"], :name => "fk_user_store_store1"
  add_index "stores_users", ["user_id", "store_id"], :name => "iduser_idstore", :unique => true
  add_index "stores_users", ["user_id"], :name => "fk_user_store_user"

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
    t.string   "name",       :limit => 45
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
end
