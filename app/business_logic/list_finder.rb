module ListFinder

		#returns array of list objects representing lists that currently contain store denoted by store_id
		def self.find_lists_by_curr_store(store_id, user_id)
		 	t_curr_list_names = List.find(:all, 
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

		#returns list of lists that contain the store_id, given an array of lists to consider
		def self.find_listers(lists, store_id)
			tempResults = List.find(:all, 
                            :conditions => ["lists.id in (?) and list_stores.store_id = ? and list_users.list_id = lists.id", lists, store_id],
                            :joins => [:list_users, :list_stores],
                            :select => "lists.name, list_users.user_id")
      results = Array.new
      
      tempResults.each do |item|
        userName = User.find(:all, :conditions => ["? = users.id",item.user_id], :select => "users.first_name").first
        results.push([item.name,userName.first_name]) 
      end

      return results                            
		end


end