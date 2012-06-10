module StoreFinder

	#returns list of stores given array of store_ids
	def find_stores_by_ids(store_ids)
        stores = Store.find(:all,
                           :conditions => ["id IN (?)", store_ids],
                           :select => "name, id")
    end

   	#probably don't need; can be done through association
  	def find_lists_stores(list_id)
	  	stores = Store.find(:all,
                         :conditions => ["list_stores.list_id = ?", list_id],
                         :joins => [:list_stores],
                         :select => "stores.name, stores.id")
  	end
      	
      #simple search
    def find_store_ids_by_fuzzy_match(search_string)
      	stores = Store.where("name like ?  or detail_info like ?", search_string, search_string).select("id").all
    end

    def self.in_favorites(lists)

      lists.each do |list|
        if list.name == 'Favorites'
          return true
        end
      end

      return false
    end

    def self.in_been_to(lists)

      lists.each do |list|
        if list.name == "Places I've Been To"
          return true
        end
      end

      return false
    end

    def self.in_want_to_go_to(lists)

      lists.each do |list|
        if list.name == "Places I Want To Go"
          return true
        end
      end

      return false
    end


    def self.in_default_lists(user_id, store_id)

      lists = ListFinder.find_lists_by_curr_store(store_id, user_id)

      results = {:favorite => in_favorites(lists), :been_to => in_been_to(lists), :want_to => in_want_to_go_to(lists)}

      return results

    end

end