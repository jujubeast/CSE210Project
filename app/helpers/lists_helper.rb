module ListsHelper
  class ListsEntity
    def initialize(list_id)
      @list = List.find(list_id)
    end
    
    def current_list
      @list
    end
    
    def associated_stores
      associated_stores = Array.new
      @list.list_stores.each do |list_store|
        associated_stores.push(list_store.store)
      end
      associated_stores
    end
  end
end
