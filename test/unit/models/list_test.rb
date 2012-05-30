require 'test_helper'

class ListTest < ActiveSupport::TestCase
  test "create list and retrieve" do
    testlist = List.new
    testlist.name = "hanbo list 1"
    testlist.privacy = 1
    
    testlist.save
    
    list_got = List.where("name = ?", testlist.name).first
    assert list_got != nil
    assert list_got.name == testlist.name
    assert list_got.privacy == testlist.privacy
  end

  test "create list and associate with a store" do
    testlist = List.new
    testlist.name = "hanbo list 1"
    testlist.privacy = 1
    
    testlist.save
    
    list_got = List.where("name = ?", testlist.name).first
    assert list_got != nil
    assert list_got.name == testlist.name
    assert list_got.privacy == testlist.privacy

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
    assert store_got.telephone == teststore.telephone
    assert store_got.hours == teststore.hours
    assert store_got.detail_info == teststore.detail_info
    
    list_got.list_stores[0] = ListStore.new
    list_got.list_stores[0].store = store_got
    list_got.save
    
    list2_got = List.where("name = ?", testlist.name).first
    assert list2_got != nil
    assert list2_got.name == testlist.name
    assert list2_got.privacy == testlist.privacy
    assert list2_got.list_stores != nil
    assert list2_got.list_stores[0] != nil
    assert list2_got.list_stores[0].store != nil
    assert list2_got.list_stores[0].store.name == teststore.name
    assert list2_got.list_stores[0].store.detail_info == teststore.detail_info
    assert list2_got.list_stores[0].store.street_2 == teststore.street_2
    assert list2_got.list_stores[0].store.state == teststore.state
    assert list2_got.list_stores[0].store.zipcode == teststore.zipcode 
    assert list2_got.list_stores[0].store.hours == teststore.hours
  end
end