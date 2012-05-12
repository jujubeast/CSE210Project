require 'test_helper'

class TagStoreUserTest < ActiveSupport::TestCase
    test "add store and fuzzy search" do
      # create 5 stores
      teststore1 = Store.new
      teststore1.name = "hanbo taco shop 1"
      teststore1.detail_info = "this a test from hanbo taco shop 1"
      teststore1.save
      teststore2 = Store.new
      teststore2.name = "hanbo fish taco shop1"
      teststore2.detail_info = "this a test from hanbo fish taco shop 1"
      teststore2.save
      teststore3 = Store.new
      teststore3.name = "hanbo burrito shop 1"
      teststore3.detail_info = "this test from hanbo burrito shop 1"
      teststore3.save
      teststore4 = Store.new
      teststore4.name = "ding mexican food 1"
      teststore4.detail_info = "this test from ding mexican food 1"
      teststore4.save
      teststore5 = Store.new
      teststore5.name = "ding chinese food 1"
      teststore5.detail_info = "this a test from ding chinese food 1"
      teststore5.save
      
      # create two tags      
      testtag1 = Tag.new
      testtag1.name = "mexican food"
      testtag1.category_id = 1
      testtag1.save
            
      testtag2 = Tag.new
      testtag2.name = "taco place"
      testtag2.category_id = 2
      testtag2.save
      
      # for tag #1 associate two stores
      stu1 = StoreTagUser.new
      stu1.store_id = teststore3.id 
      stu1.tag_id = testtag1.id
      stu1.user_id = 1
      stu1.save
      
      stu2 = StoreTagUser.new
      stu2.store_id = teststore4.id 
      stu2.tag_id = testtag1.id
      stu2.user_id = 2
      stu2.save
      
      # using store, you will find one store
      store_ids = Store.find_store_ids_by_fuzzy_match("%mexican%")
      assert store_ids.size == 1
      assert store_ids[0].id == teststore4.id
      
      tag_ids = Tag.find_id_by_fuzzy_match("%mexican%")
      assert tag_ids.size == 1
      assert tag_ids[0].id == testtag1.id
      
      # using tags, you will find two stores, one is a duplicate, remove by supplying the store list.
      more_store_ids = StoreTagUser.find_store_ids_by_ids(tag_ids, store_ids)
      assert more_store_ids.size == 1
      assert more_store_ids[0].store_id = teststore3.id
    end

    test "add store and fuzzy search 2" do
      # create 5 stores
      teststore1 = Store.new
      teststore1.name = "hanbo taco shop 1"
      teststore1.detail_info = "this a test from hanbo taco shop 1"
      teststore1.save
      teststore2 = Store.new
      teststore2.name = "hanbo fish taco shop1"
      teststore2.detail_info = "this a test from hanbo fish taco shop 1"
      teststore2.save
      teststore3 = Store.new
      teststore3.name = "hanbo burrito shop 1"
      teststore3.detail_info = "this test from hanbo burrito shop 1"
      teststore3.save
      teststore4 = Store.new
      teststore4.name = "ding mexican food 1"
      teststore4.detail_info = "this test from ding mexican food 1"
      teststore4.save
      teststore5 = Store.new
      teststore5.name = "ding chinese food 1"
      teststore5.detail_info = "this a test from ding chinese food 1"
      teststore5.save
      
      # create two tags      
      testtag1 = Tag.new
      testtag1.name = "mexican food"
      testtag1.category_id = 1
      testtag1.save
            
      testtag2 = Tag.new
      testtag2.name = "taco place"
      testtag2.category_id = 2
      testtag2.save
      
      # for tag #1 associate two stores
      stu1 = StoreTagUser.new
      stu1.store_id = teststore3.id 
      stu1.tag_id = testtag1.id
      stu1.user_id = 1
      stu1.save
      
      stu2 = StoreTagUser.new
      stu2.store_id = teststore4.id 
      stu2.tag_id = testtag1.id
      stu2.user_id = 2
      stu2.save
      
      # using store, you will find 3 matching stores
      store_ids = Store.find_store_ids_by_fuzzy_match("%shop%")
      assert store_ids.size == 3
      assert store_ids[0].id == teststore1.id
      assert store_ids[1].id == teststore2.id
      assert store_ids[2].id == teststore3.id
      
      # you find no tags matching
      tag_ids = Tag.find_id_by_fuzzy_match("%shop%")
      assert tag_ids.size == 0
      
      # using tags, find no matching stores, because there is no tags can be used.
      more_store_ids = StoreTagUser.find_store_ids_by_ids(tag_ids, store_ids)
      assert more_store_ids.size == 0
    end

    test "add store and fuzzy search 3" do
      # create 5 stores
      teststore1 = Store.new
      teststore1.name = "hanbo taco shop 1"
      teststore1.detail_info = "this a test from hanbo taco shop 1"
      teststore1.save
      teststore2 = Store.new
      teststore2.name = "hanbo fish taco shop1"
      teststore2.detail_info = "this a test from hanbo fish taco shop 1"
      teststore2.save
      teststore3 = Store.new
      teststore3.name = "hanbo burrito shop 1"
      teststore3.detail_info = "this test from hanbo burrito shop 1"
      teststore3.save
      teststore4 = Store.new
      teststore4.name = "ding mexican food 1"
      teststore4.detail_info = "this test from ding mexican food 1"
      teststore4.save
      teststore5 = Store.new
      teststore5.name = "ding chinese food 1"
      teststore5.detail_info = "this a test from ding chinese food 1"
      teststore5.save
      
      # create two tags      
      testtag1 = Tag.new
      testtag1.name = "mexican food"
      testtag1.category_id = 1
      testtag1.save
            
      testtag2 = Tag.new
      testtag2.name = "taco place"
      testtag2.category_id = 2
      testtag2.save
      
      # for tag #1 associate two stores
      stu1 = StoreTagUser.new
      stu1.store_id = teststore3.id 
      stu1.tag_id = testtag1.id
      stu1.user_id = 1
      stu1.save
      
      stu2 = StoreTagUser.new
      stu2.store_id = teststore1.id 
      stu2.tag_id = testtag2.id
      stu2.user_id = 2
      stu2.save

      stu3 = StoreTagUser.new
      stu3.store_id = teststore2.id 
      stu3.tag_id = testtag2.id
      stu3.user_id = 2
      stu3.save
      
      # using store, you will not find any match
      store_ids = Store.find_store_ids_by_fuzzy_match("%taco%place%")
      assert store_ids.size == 0
      
      # you will find one tag match the string
      tag_ids = Tag.find_id_by_fuzzy_match("%taco%place%")
      assert tag_ids.size == 1
      assert tag_ids[0].id == testtag2.id
      
      # using tags, you will find two stores, since there is no stores to remove, both will return.
      more_store_ids = StoreTagUser.find_store_ids_by_ids(tag_ids, store_ids)
      puts more_store_ids.size.to_s
      assert more_store_ids.size == 2
      assert more_store_ids[0].store_id== stu2.store_id
      assert more_store_ids[1].store_id== stu3.store_id
    end
    
end