class StoreTagUser < ActiveRecord::Base
  attr_accessible :store_id, :tag_id, :user_id
end