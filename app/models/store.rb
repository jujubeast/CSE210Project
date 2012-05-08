class Store < ActiveRecord::Base
	has_many :lists_stores
	has_many :lists, :through => :lists_stores
  	attr_accessible :been_to, :can_delete, :detail_info, :favorite, :image, :name

  	#finds stores given ARRAY of store ids
  	def self.find_stores_by_ids(store_ids)
  		stores = Store.find(:all,
                         :conditions => ["id IN (?)", store_ids],
                         :select => "name, id")
  	end
end
