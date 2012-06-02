require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "create user and retrieve" do
    testuser = User.new
    testuser.fb_id = "hanbosun"
    testuser.email = "hanbosun@hanbosun.com"
    testuser.first_name = "hanbo"
    testuser.last_name = "sun"
    testuser.password = "dumb-password"
    
    testuser.save
    
    user_got = User.where("last_name = ?", testuser.last_name).first
    assert user_got != nil
    assert user_got.fb_id == testuser.fb_id
    assert user_got.email == testuser.email
    assert user_got.first_name == testuser.first_name
    assert user_got.last_name == testuser.last_name
    assert user_got.password == testuser.password
  end
  
  test "create user and user_store association" do
    testuser = User.new
    testuser.fb_id = "hanbosun"
    testuser.email = "hanbosun@hanbosun.com"
    testuser.first_name = "hanbo"
    testuser.last_name = "sun"
    testuser.password = "dumb-password"
    
    testuser.save
    
    teststore = Store.new
    teststore.name = "hanbo's test store"
    teststore.detail_info = "This is a test store created by hanbo"
    teststore.street_1 = "4928 Elm St."
    teststore.street_2 = "Suite 22"
    teststore.city = "San Diego"
    teststore.state = "CA"
    teststore.zipcode = "92119"
    teststore.telephone = "603-827-5768"
    teststore.hours = "9AM - 5PM"
    
    teststore.save
    
    store_got = Store.where("name = ?", teststore.name).first
    assert store_got != nil
    user_got = User.where("fb_id = ?", testuser.fb_id).first
    assert user_got != nil
    
    test_storeuser = StoreUser.new
    test_storeuser.been_there = 5
    
    user_got.store_users[0] = StoreUser.new
    user_got.store_users[0].store = store_got
    user_got.store_users[0].been_there = 5
    
    user_got.save
    
    user_got2 = User.where("fb_id = ?", testuser.fb_id).first
    assert user_got2 != nil
    
    assert user_got2.store_users[0] != nil
    assert user_got2.store_users[0].been_there == 5
    assert user_got2.store_users[0].store.name == teststore.name
    assert user_got2.store_users[0].store.detail_info == teststore.detail_info
    assert user_got2.store_users[0].store.street_2 == teststore.street_2
    assert user_got2.store_users[0].store.state == teststore.state
    assert user_got2.store_users[0].store.zipcode == teststore.zipcode
  end
  
  test "create user and list association" do
    testuser = User.new
    testuser.fb_id = "hanbosun"
    testuser.email = "hanbosun@hanbosun.com"
    testuser.first_name = "hanbo"
    testuser.last_name = "sun"
    testuser.password = "dumb-password"
    testuser.save
    
    user_got = User.where("fb_id = ?", testuser.fb_id).first
    assert user_got != nil
    
    testlist = List.new
    testlist.name = "hanbo test list"
    testlist.privacy = 5
    testlist.save
    
    list_got = List.where("name = ?", testlist.name).first
    assert list_got != nil
    
    user_got.list_users[0] = ListUser.new
    user_got.list_users[0].privilege = 1
    user_got.list_users[0].list = list_got
    user_got.save
    
    user2_got = User.where("fb_id = ?", testuser.fb_id).first
    assert user2_got != nil
    assert user2_got.fb_id == testuser.fb_id
    assert user2_got.list_users[0] != nil
    assert user2_got.list_users[0].privilege == 1
    assert user2_got.list_users[0].list != nil
    assert user2_got.list_users[0].list.name = testlist.name
    assert user2_got.list_users[0].list.privacy = testlist.privacy
  end

  test "create user, store, and tags" do
  end
end