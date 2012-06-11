module ListLogic

	def self.create_new_list(list_params)
		list = List.new(list_params)
	end

	def self.create_default_lists(user_id)

		been_to = List.new
		been_to.name = "Places I've Been To"
		been_to.deletable = false

		want_to = List.new
		want_to.name = "Places I Want To Go"
		want_to.deletable = false

		favorites = List.new
		favorites.name = "Favorites"
		favorites.deletable = false

		user = User.find(user_id)

		been_to_lu = ListUser.new
		been_to_lu.list = been_to

		want_to_lu = ListUser.new
		want_to_lu.list = want_to

		favorites_lu = ListUser.new
		favorites_lu.list = favorites

		user.list_users << been_to_lu
		user.list_users << want_to_lu
		user.list_users << favorites_lu

	end

	def self.check_deletable(list_id)
		list = List.find(list_id)
		list.deletable
	end

	#subscribe user_id to list_id, belonging to another user
	def self.subscribe_list(user_id, list_id)

		the_list = List.find(list_id)
		the_user = User.find(user_id)
		new_list_user = ListUser.new
		new_list_user.list = the_list
		new_list_user.privilege = 2
		the_user.list_users << new_list_user
	end

	def self.unsubscribe_list(user_id, list_id)
		list_user = ListUser.where(:user_id => user_id, :list_id => list_id).first
		list_user.destroy
	end


end