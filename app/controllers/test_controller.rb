class TestController < ApplicationController
  def setup
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
    
    stu1 = StoreTagUser.new
    stu1.store_id = teststore3.id
    stu1.tag_id = testtag1.id
    stu1.user_id = 1
    stu1.save
    
    puts "teststore3.id " + teststore3.id.to_s + "\n"

    stu2 = StoreTagUser.new
    stu2.store_id = teststore4.id 
    stu2.tag_id = testtag1.id
    stu2.user_id = 2
    stu2.save

    puts "teststore4.id " + teststore4.id.to_s + "\n"
    
    stu3 = StoreTagUser.new
    stu3.store_id = teststore1.id
    stu3.tag_id = testtag2.id
    stu3.user_id = 3
    stu3.save

    stu4 = StoreTagUser.new
    stu4.store_id = teststore2.id 
    stu4.tag_id = testtag2.id
    stu4.user_id = 4
    stu4.save
    
    @setup_status = "Setup completed and successful"
  end

  def simple_search_test_input
  end
  
  def test_simple_search
    search_query = params[:search_query]
    puts "Query: " + search_query + "\n"
    search_op = SimpleSearchOperation.new(search_query)
    search_op.do_search
    @view_data = search_op.view_data
    
    puts "return size " + @view_data.size.to_s + "\n"
  end
  
end