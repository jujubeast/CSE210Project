require 'test_helper'

class StoreTest < ActiveSupport::TestCase
  test "create store and retrieve" do
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
  end
end