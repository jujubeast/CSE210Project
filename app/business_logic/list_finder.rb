module ListFinder

		#returns array of list objects representing lists that currently contain store denoted by store_id
		def self.find_lists_by_curr_store(store_id, user_id)
		 	t_curr_list_names = List.find(:all, 
                                  :conditions => ["list_users.user_id = ? and list_stores.store_id=? and list_users.privilege IN (?)", user_id, store_id, [0, 1]],
                                  :joins => [:list_users, :list_stores],
                                  :select => "lists.name, lists.id")
		end
		#finds all lists belonging to the current user that are not a part of curr_lists, an array of list names
		def self.find_all_other_lists(curr_lists, user_id)
			list_names = List.find(:all,
                               :conditions => ["lists.name NOT IN (?) and list_users.user_id = ? and list_users.privilege IN (?)", curr_lists, user_id, [0, 1]], 
                               :joins => [:list_users],
                               :select => "lists.name, lists.id")
		end

    def self.find_users_list_by_name(name, user_id)
      user = User.find(user_id)

      user.list_users.each do |list_user|
        if list_user.list.name == name
          return list_user.list_id
        end
      end

      return nil

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

		def self.findDefaultListHash(user_id, stores)
    		default_list_state = Hash.new

    		stores.each do |store|
      		default_list_state[store.id] = ListFinder.in_default_lists(user_id, store.id)
    		end

    		return default_list_state
  		end

	    def self.in_default_lists(user_id, store_id)

      	 lists = ListFinder.find_lists_by_curr_store(store_id, user_id)

      	 results = {:favorite => ListFinder.in_favorites(lists, user_id), :been_to => ListFinder.in_been_to(lists, user_id), :want_to => ListFinder.in_want_to_go_to(lists, user_id)}

   		   return results

	     end

    def self.in_favorites(lists, user_id)

      list_name = "Favorites"
      list_object = Hash.new
      list_object[:exists] = false
      list_object[:list_id] = find_users_list_by_name(list_name, user_id)

      lists.each do |list|
          if list.name == list_name
              list_object[:exists] = true
          end
        end

        return list_object
    end

    def self.in_been_to(lists, user_id)

      list_name = "Places I Have Been To"
      list_object = Hash.new
      list_object[:exists] = false
      list_object[:list_id] = find_users_list_by_name(list_name, user_id)

      lists.each do |list|
          if list.name == list_name
              list_object[:exists] = true
          end
        end

        return list_object
    end

    def self.in_want_to_go_to(lists, user_id)

      list_name = "Places I Want To Go"
      list_object = Hash.new
      list_object[:exists] = false
      list_object[:list_id] = find_users_list_by_name(list_name, user_id)

      lists.each do |list|
          if list.name == list_name
              list_object[:exists] = true
          end
        end

        return list_object
    end


    def self.findListPrivileges(user_id, lists)
      list_privileges = Hash.new

        lists.each do |list|
            result = ListUser.find(:all, :conditions => ['list_users.user_id = ? and list_users.list_id = ?', user_id, list.id]).first()
            list_privileges[list.id] = result.privilege
        end

        return list_privileges

    end

    #find the subbed lists of the user given by user_id
    def self.findUserSubbedLists(user_id)
        lists = ListUser.find(:all, :conditions => ['list_users.user_id = ? and list_users.privilege = 2', user_id])
        
        results = Array.new
        lists.each do |list|
          results.push(list.list_id)
        end

        return results
    end 

    def self.find_list_owners(lists)
      results = Hash.new
      lists.each do |list|
        list_user = ListUser.where(:list_id => list.id, :privilege => 0).first
        user_name = User.find(list_user.user_id)
        results[list.id] = user_name.first_name
      end

      return results

    end

end