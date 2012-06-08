class ListEntity
  def initialize(list_id)
    @list = List.find(list_id)
  end
  
  def current_list
    @list
  end
  
  def add_store_to_current_list(store_id)
    puts "+++++++"
    puts @list.name
    list_store = @list.list_stores.first_or_create(:store_id => store_id)
    puts list_store.store.name
    puts "++++++"
    return list_store
  end

  def remove_store_from_current_list(store_id)
    list_id = @list.id
    ListStores.delete_all( \
      :conditions => ["list_id = ? and store_id = ?", list_id, store_id] \
    )
  end
      
  def associated_stores
    associated_stores = Array.new
    @list.list_stores.each do |list_store|
      associated_stores.push(list_store.store)
    end
    associated_stores
  end
end