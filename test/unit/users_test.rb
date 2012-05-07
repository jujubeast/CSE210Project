require 'test_helper'

class UsersTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "insert and retrieve" do
    puts "Start testing"
    
    testuser = Users.new
    testuser.name = "hanbo sun"
    testuser.fb_id = "hanbo_on_crack@crackhead.com"

    puts "... before save"
    
    testuser.save
    
    user_retrieved = Users.first
    assert user_retrieved.name == "hanbo sun"
    assert user_retrieved.fb_id == "hanbo_on_crack@crackhead.com"

    puts "... after retrieve"
  end

  test "Try retrieve ID" do
    puts "Start testing"
    
    testuser = Users.new
    testuser.name = "hanbo sun"
    testuser.fb_id = "hanbo_on_crack@crackhead.com"

    puts "... before save"
    
    testuser.save
    
    user_retrieved = Users.first
    puts "user id: " + user_retrieved.id.to_s
    assert user_retrieved.id == 1
    assert user_retrieved.name == "hanbo sun"
    assert user_retrieved.fb_id == "hanbo_on_crack@crackhead.com"

    puts "... after retrieve"
  end
end
