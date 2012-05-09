class ListStore < ActiveRecord::Base
	belongs_to :list
	belongs_to :store
   attr_accessible :store_id, :list_id

   #finds store ids based on a single list id
   def self.find_store_ids(list_id)
   		store_ids = find(:all,
                         :conditions => {:list_id => list_id},
                         :select => "store_id").map {|x| x.store_id}
   end
end

