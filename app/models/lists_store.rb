class ListsStore < ActiveRecord::Base
	belongs_to :list
	belongs_to :store
   attr_accessible :store_id, :list_id
end
