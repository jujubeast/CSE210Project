require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "insert and retrieve" do
    puts "Start testing"
    
    testuser = User.new
    testuser.name = "hanbo sun"
    testuser.fb_id = "hanbo_on_crack@crackhead.com"

    puts "... before save"
    
    testuser.save
    
    user_retrieved = User.first
    assert user_retrieved.id == 1
    assert user_retrieved.name == "hanbo sun"
    assert user_retrieved.fb_id == "hanbo_on_crack@crackhead.com"

    puts "... after retrieve"
  end

  test "insert for not null" do
    puts "Start testing"
    
    testuser = User.new
    testuser.fb_id = "hanbo_on_crack@crackhead.com"

    puts "... before save"

    begin
      testuser.save
    rescue ActiveRecord::StatementInvalid => e
      puts "Caught exception... Expected."
    end    
  end

  test "insert for not null 2" do
    puts "Start testing"
    
    testuser = User.new
    testuser.name = "hanbo sun"

    puts "... before save"

    begin
      testuser.save
    rescue ActiveRecord::StatementInvalid => e
      puts "Caught exception... Expected."
    end    
  end

end
