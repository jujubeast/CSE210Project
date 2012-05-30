require 'test_helper'

class TagTest < ActiveSupport::TestCase
  test "create tag and retrieve" do
    testtag = Tag.new
    testtag.name = "Stupid Taco"
    testtag.user_id = 5
    
    testtag.save
    
    tag_got = Tag.where("name = ?", testtag.name).first
    assert tag_got != nil
    assert tag_got.name == testtag.name
    assert tag_got.user_id == 5
  end
  
  test "create tag and category associations" do
    category_val = "My test category"
    category_val2 = "My test category 2"
    category_val3 = "My test category 3"
    
    testtag = Tag.new
    testtag.name = "Stupid Taco"
    testtag.user_id = 8
    
    testtag.categories[0] = Category.new
    testtag.categories[0].category = category_val
    testtag.save
    
    tag_got = Tag.where("name = ?", testtag.name).first
    assert tag_got != nil
    assert tag_got.name == testtag.name
    assert tag_got.user_id == testtag.user_id
    assert tag_got.categories != nil   
    assert tag_got.categories[0] != nil
    assert tag_got.categories[0].category == category_val
    
    category_got = Category.where("category = ?", category_val).first
    assert category_got != nil
    assert category_got.category == category_val
    assert category_got.tags != nil
    assert category_got.tags[0] != nil
    assert category_got.tags[0].name = testtag.name
    assert category_got.tags[0].user_id = testtag.user_id
    
    tag_got.categories[1] = Category.new
    tag_got.categories[1].category = category_val2
    tag_got.save
    tag2_got = Tag.where("name = ?", testtag.name).first
    assert tag2_got != nil
    assert tag2_got.name == testtag.name
    assert tag2_got.user_id = testtag.user_id
    assert tag2_got.categories != nil   
    assert tag2_got.categories[1] != nil
    assert tag2_got.categories[1].category == category_val2

    # if both the category and tag has been saved, to establish the 1 to 1 relation
    # between these two, one must create a new record in the categories_tags table
    # with both ids in the row.
    testcategory2 = Category.new
    testcategory2.category = category_val3
    testcategory2.save
    
    testcategory2_got = Category.where("category = ?", category_val3).first
    assert testcategory2_got != nil
    assert testcategory2_got.category == category_val3
  
    # connect the two via the categories_tags table, by adding a new row
    categories_tags_add = CategoriesTags.new
    categories_tags_add.category_id = testcategory2_got.id
    categories_tags_add.tag_id = tag2_got.id
    categories_tags_add.save
    
    tag3_got = Tag.where("name = ?", testtag.name).first
    assert tag3_got != nil
    assert tag3_got.name == testtag.name
    assert tag3_got.user_id == testtag.user_id
    assert tag3_got.categories != nil
    assert tag3_got.categories.size == 3
    assert tag3_got.categories[2] != nil
    assert tag3_got.categories[2].category == category_val3
  end
  
  test "create user store tag and associations" do
    
    testuser = User.new
    testuser.fb_id = "hanbosun"
    testuser.email = "hanbosun@hanbosun.com"
    testuser.first_name = "hanbo"
    testuser.last_name = "sun"
    testuser.password = "dumb-password"
    testuser.save
    
    testtag = Tag.new
    testtag.name = "Taco Shop tag"
    
    testuser.tags[0] = testtag
    testuser.save
    
    user_got = User.where("fb_id = ?", testuser.fb_id).first
    assert user_got != nil
    assert user_got.fb_id == testuser.fb_id
    assert user_got.tags != nil
    assert user_got.tags.size == 1
    assert user_got.tags[0].name == testtag.name
    
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
    assert store_got.zipcode == teststore.zipcode
    
    test_storestags = StoresTags.new
    test_storestags.store_id = store_got.id
    test_storestags.tag_id = user_got.tags[0].id
    test_storestags.save
    
    user_got2 = User.where("fb_id = ?", testuser.fb_id).first
    assert user_got2 != nil
    assert user_got2.fb_id == testuser.fb_id
    assert user_got2.tags != nil
    assert user_got2.tags.size == 1
    assert user_got2.tags[0].name == testtag.name
    assert user_got2.tags[0].stores != nil
    assert user_got2.tags[0].stores.size == 1
    assert user_got2.tags[0].stores[0].name == teststore.name
    assert user_got2.tags[0].stores[0].detail_info == teststore.detail_info
    assert user_got2.tags[0].stores[0].street_1 == teststore.street_1
    assert user_got2.tags[0].stores[0].city == teststore.city
    assert user_got2.tags[0].stores[0].state == teststore.state
    assert user_got2.tags[0].stores[0].zipcode == teststore.zipcode
    assert user_got2.tags[0].stores[0].telephone == teststore.telephone
    assert user_got2.tags[0].stores[0].hours == teststore.hours
  end
  
end