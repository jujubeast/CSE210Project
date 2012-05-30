module StoresHelper
  class StoreEntity
    def initialize(store_id)
      @store = Store.find(store_id)
    end
    
    def store
      @store
    end
    
    def self.find_all
      all_available_stores = Store.find(:all)
    end
  end
end