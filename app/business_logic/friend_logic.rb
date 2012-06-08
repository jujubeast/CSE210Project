module FriendLogic

	def self.add_friend_record(user_id, friend_id)
		friend = Friend.find_or_create_by_user_id_and_friend_id(:user_id => user_id, :friend_id => friend_id)
	end

end