class ListStore < ActiveRecord::Base
  attr_accessible :store_id, :list_id
  
  # used for associating lists and stores
  belongs_to :list
  belongs_to :store
end
