class ListsUser < ActiveRecord::Base
   attr_accessible :user_id, :list_id, :owner
   belongs_to :user
   belongs_to :list
end
