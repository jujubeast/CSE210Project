class List < ActiveRecord::Base
	has_many :list_users, :dependent => :destroy
	has_many :users, :through => :lists_users
	has_many :list_stores, :dependent => :destroy
	has_many :stores, :through => :lists_stores
	attr_accessible :deletable, :name

	#finds all lists of the current user that the store designated by store_id is currently on
	def self.find_lists_by_curr_store(store_id, user_id)
		 curr_list_names = List.find(:all, 
                                  :conditions => ["list_users.user_id = ? and list_stores.store_id=?", user_id, store_id],
                                  :joins => [:list_users, :list_stores],
                                  :select => "lists.name, lists.id")
	end


	#finds all lists belonging to the current user that are not a part of curr_lists, an array of list names
	def self.find_all_other_lists(curr_lists, user_id)
		list_names = List.find(:all,
                               :conditions => ["lists.name NOT IN (?) and list_users.user_id = ?", curr_lists, user_id], 
                               :joins => [:list_users],
                               :select => "lists.name, lists.id")
	end

	#finds lists to display in views given ARRAY of list ids
	def self.find_users_lists(user_id)
		lists = List.find(:all,
                        :conditions => ["list_users.user_id = ?", user_id],
                        :joins => [:list_users],
                        :select => "lists.name, lists.id")
	end

	def self.find_listers(lists, store_id)
		results = List.find(:all, 
                            :conditions => ["lists.id in (?) and list_stores.store_id=?", lists, store_id],
                            :joins => [:list_users, :list_stores],
                            :select => "lists.name, lists.id")
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

end
