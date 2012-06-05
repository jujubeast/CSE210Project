class StoreUser < ActiveRecord::Base
  attr_accessible :user_id, :store_id, :been_there
  
  # used for mapping user and store relation
  belongs_to :user
  belongs_to :store
end
