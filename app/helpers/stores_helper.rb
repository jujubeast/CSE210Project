module StoresHelper
  class StoreEntity
    def initialize
      @store = nil
    end
    
    def find_by_id(store_id)
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