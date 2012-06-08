module SearchLogic
	

	def self.update_friends_table(friends_list, user_id)

		user = UserFinder.find_by_user_id(user_id)

    	friends_list.each do |friend|
      		if User.exists?(:fb_id => friend.identifier)
        		friend = UserFinder.find_by_fb_id(friend.identifier)
        		FriendLogic.add_friend_record(user_id, friend.id)
        		FriendLogic.add_friend_record(friend.id, user_id)		
      		end
    	end


	end
	
end