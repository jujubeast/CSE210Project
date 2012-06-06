class List < ActiveRecord::Base
	has_many :list_users, :dependent => :destroy
	has_many :users, :through => :lists_users
	has_many :list_stores, :dependent => :destroy
	has_many :stores, :through => :lists_stores
	attr_accessible :deletable, :name

	include ListFinder

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
