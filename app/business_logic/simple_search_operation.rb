class SimpleSearchOperation
  
  def initialize(query_val)
    @query_str = query_val
    @view_data = nil 
  end
  
  private
  def prepare_search_criteria
    @query_str = @query_str.gsub(" ", "%")
    @query_str = "%" + @query_str + "%"
    
    puts "Search for: " + @query_str + "\n"
  end
  
  private
  def search_all_stores
    store_ids = Store.find_store_ids_by_fuzzy_match(@query_str)
    return store_ids
  end

  def search_all_tags(excluced_store_ids)
    tag_ids = Tag.find_id_by_fuzzy_match(@query_str)
    more_store_ids = StoreTagUser.find_store_ids_by_ids(tag_ids, excluced_store_ids)
    return more_store_ids
  end
  
  def retrieve_found_stores(store_ids)
    @view_data = Store.find_stores_by_ids(store_ids)
  end
  
  #def display_store_name(ids)
  #  stores = Store.find_stores_by_ids(ids)
  #  stores.each { |store| puts "store name: " + store.name + "\n" }
  #end
  
  public  
  def do_search
    prepare_search_criteria
    store_ids = search_all_stores
    
    #puts "Store search: " + store_ids.size.to_s
    #display_store_name(store_ids)
    more_store_ids = search_all_tags(store_ids)
    
    store_id_array = Array.new
    store_ids.each {
      |store_id|
      store_id_array.append(store_id.id)
    }
    more_store_ids.each {
      |store_id|
      store_id_array.append(store_id.store_id)      
    }
    #puts "Tag search: " + more_store_ids.size.to_s
    #display_store_name(more_store_ids)
    retrieve_found_stores(store_id_array)
  end
  
  def view_data
    return @view_data
  end
  
end