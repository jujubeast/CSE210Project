class AddFriendsTable < ActiveRecord::Migration
  def up
  	create_table :friends do |t|
  		t.integer :user_id
  		t.integer :friend_id
  	end
  end

  def down
  end
end
