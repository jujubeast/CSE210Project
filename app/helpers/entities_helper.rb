module EntitiesHelper
  
  class StoresEntityDataAccessHelper
    def save(store_entity)
      store_entity.save      
    end
    
    def retrieve_by_exact_value(fieldname, value_search)
      criteria = fieldname + " = ?"
      retrieved_store = Stores.where(criteria, value_search).first
      return retrieved_store
    end

    def retrieve_by_fuzzy_match(fieldname, value_search)
      name = "%" + value_search + "%"
      criteria = fieldname + " like ?"
      retrieved_store = Stores.where(criteria, value_search).first
      return retrieved_store
    end

  end
end
