require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "create category and retrieve" do
    testcategory = Category.new
    testcategory.category = "Stupid Cat 1"
    
    testcategory.save
    
    category_got = Category.where("category = ?", testcategory.category).first
    assert category_got != nil
    assert category_got.category == testcategory.category
  end
end