require 'test_helper'

class TagTest < ActiveSupport::TestCase
  test "create tag and retrieve" do
    testtag = Tag.new
    testtag.name = "Stupid Taco"
    
    testtag.save
    
    tag_got = Tag.where("name = ?", testtag.name).first
    assert tag_got != nil
    assert tag_got.name == testtag.name
  end
  
  
  test "create user store tag and associations" do
    testuser = User.new
    testuser.fb_id = "hanbosun"
    testuser.email = "hanbosun@hanbosun.com"
    testuser.first_name = "hanbo"
    testuser.last_name = "sun"
    testuser.password = "dumb-password"
    testuser.save

    user_got = User.where("fb_id = ?", testuser.fb_id).first
    assert user_got != nil
    assert user_got.fb_id == testuser.fb_id
        
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
    assert store_got.name == teststore.name    
    
    cat = Category.where(:category => "test").first_or_create()
    assert cat.id != nil
    tag = cat.tags.where(:name => "testtag1").first_or_create()
    assert tag.id != nil
    stu = tag.store_tag_users.where(:user_id => user_got.id,:store_id => store_got.id).create()
    assert stu.id != nil
    
    tag2 = cat.tags.where(:name => "testtag2").first_or_create()
    assert tag2.id != nil
    stu2 = tag2.store_tag_users.where(:user_id => user_got.id,:store_id => store_got.id).create()
    assert stu2.id != nil
    
    # retrieve the reviews
    storetagusers = StoreTagUser.joins(:tag => :category).select("name, count(*) as tag_num")
      .where("category = ? and store_id = ?",cat.category, store_got.id) \
      .group("tag_id,name").order("tag_num DESC")
    
    store_review = StoreReview.new
    store_review.add_category(cat.category)
    storetagusers.each do 
      |test_x|
      store_review.add_tag(cat.category, test_x.name)
    end
    
    assert store_review.all_categories.size == 1
    all_tags_found = store_review.find_tags(store_review.all_categories[0])
    assert all_tags_found.size == 2
  end
  
end