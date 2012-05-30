class List < ActiveRecord::Base
	has_many :list_users, :dependent => :destroy
	has_many :users, :through => :lists_users
	has_many :list_stores, :dependent => :destroy
	has_many :stores, :through => :lists_stores
	attr_accessible :can_delete, :name

	#finds all lists of the current user that the store designated by store_id is currently on
	def self.find_lists_by_curr_store(store_id, user_id)
		 curr_list_names = List.find(:all, 
                                  :conditions => ["list_users.user_id = ? and list_stores.store_id=?", user_id, store_id],
                                  :joins => [:list_users, :list_stores],
                                  :select => "lists.name").map {|x| x.name}
	end


	#finds all lists belonging to the current user that are not a part of curr_lists, an array of list names
	def self.find_all_other_lists(curr_lists, user_id)
		list_names = List.find(:all,
                               :conditions => ["lists.name NOT IN (?) and list_users.user_id = ?", curr_lists, user_id], 
                               :joins => [:list_users],
                               :select => "lists.name").map {|x| x.name}
	end

	#finds lists to display in views given ARRAY of list ids
	def self.find_users_lists(user_id)
		lists = List.find(:all,
                        :conditions => ["list_users.user_id = ?", user_id],
                        :joins => [:list_users],
                        :select => "lists.name, lists.id")
	end

end
