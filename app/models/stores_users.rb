class StoresUsers < ActiveRecord::Base
  attr_accessible :store_id, :user_id, :visited
end
