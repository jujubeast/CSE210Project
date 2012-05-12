require 'test_helper'

class StoresTest < ActiveSupport::TestCase
    test "add store and fuzzy search" do
      teststore = Store.new;
      teststore.name = "han's store"
      teststore.detail_info = "han test"
      teststore.save
      
      stores = Store.find_store_ids_by_fuzzy_match("%han%")
      assert stores.size == 1
      
      store = stores[0]
      assert store.id == teststore.id
    end

    test "add store and fuzzy search 2" do
      teststore = Store.new;
      teststore.name = "han's store"
      teststore.detail_info = " simple test"
      teststore.save
      
      stores = Store.find_store_ids_by_fuzzy_match("%han%")
      assert stores.size == 1
      
      store = stores[0]
      assert store.id == teststore.id
    end

    test "add store and fuzzy search 3" do
      teststore = Store.new;
      teststore.name = "test store"
      teststore.detail_info = "simple test han"
      teststore.save
      
      stores = Store.find_store_ids_by_fuzzy_match("%han%")
      assert stores.size == 1
      
      store = stores[0]
      assert store.id == teststore.id
    end

    test "add store and fuzzy search 4" do
      teststore1 = Store.new;
      teststore1.name = "test store"
      teststore1.detail_info = "simple test han"
      teststore1.save

      teststore2 = Store.new;
      teststore2.name = "test store  han"
      teststore2.detail_info = "simple test store"
      teststore2.save

      teststore3 = Store.new;
      teststore3.name = "test store ding"
      teststore3.detail_info = "simple test store from ding"
      teststore3.save
      
      stores = Store.find_store_ids_by_fuzzy_match("%han%")
      assert stores.size == 2
      
      store = stores[0]
      assert store.id == teststore1.id

      store = stores[1]
      assert store.id == teststore2.id

      stores = Store.find_store_ids_by_fuzzy_match("%store%")
      assert stores.size == 3
      
      store = stores[0]
      assert store.id == teststore1.id

      store = stores[1]
      assert store.id == teststore2.id

      store = stores[2]
      assert store.id == teststore3.id
    end
end