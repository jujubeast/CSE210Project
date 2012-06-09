module FriendLogic

	def self.add_friend_record(user_id, friend_id)
		friend = Friend.find_or_create_by_user_id_and_friend_id(:user_id => user_id, :friend_id => friend_id)
	end

	#returns array of User objects representing the friends of User with user_id
	def self.find_friends(user_id)
		friend_objects = User.find(user_id).friends

		friends = Array.new
		friend_objects.each do |friend|
			friends.push(User.find(friend.friend_id))
		end

		return friends
	end

end