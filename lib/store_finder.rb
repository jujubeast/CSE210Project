module StoreFinder

	def self.included(base)
		base.extend ClassMethods
	end

	module ClassMethods
		
		def find_stores_by_ids(store_ids)
        stores = Store.find(:all,
                            :conditions => ["id IN (?)", store_ids],
                            :select => "name, id")
    	end

  		def find_lists_stores(list_id)
	  		stores = Store.find(:all,
                         	:conditions => ["list_stores.list_id = ?", list_id],
                         	:joins => [:list_stores],
                         	:select => "stores.name, stores.id")
  		end
      	
    	def find_store_ids_by_fuzzy_match(search_string)
      		stores = Store.where("name like ?  or detail_info like ?", search_string, search_string).select("id").all
    	end

	end

end