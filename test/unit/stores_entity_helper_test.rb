require 'test_helper'

class StoreEntityHelperTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "insert and retrieve" do
    puts "Store Entity Helper test 1"
    
    teststore = Stores.new
    teststore.name = "hanbo's dimsum palace"
    teststore.detail_info = "This is a test tore created by hanbo. It serves dimsum during lunch time, and entree during dinner time."
    
    dataaccess = EntitiesHelper::StoresEntityDataAccessHelper.new
    dataaccess.save(teststore);
    teststore_found = Stores.find(1);
    assert teststore_found != nil
    
    teststore_found2 = dataaccess.retrieve_by_exact_value("name", "hanbo's dimsum palace")
    assert teststore_found2 != nil
    assert teststore_found2.id == 1
    assert teststore_found2.name == teststore_found.name    
    assert teststore_found2.detail_info == teststore_found.name    
  end
end 