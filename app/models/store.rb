class Store < ActiveRecord::Base
	has_many :list_stores
	has_many :lists, :through => :list_stores
  	attr_accessible :been_to, :can_delete, :detail_info, :favorite, :image, :name, :pic,:street_1,:street_2,:city,:state,:zipcode,:telephone,:hours,:website
  	#finds stores given ARRAY of store ids
  	def self.find_stores_by_ids(store_ids)
  		stores = Store.find(:all,
                         :conditions => ["id IN (?)", store_ids],
                         :select => "name, id")
  	end
      	
    def self.find_store_ids_by_fuzzy_match(search_string)
      stores = Store.where(
        "name like ?  or detail_info like ?", search_string, search_string, 
      ).select("id").all
    end
end
