class ListUser < ActiveRecord::Base
   attr_accessible :user_id, :list_id, :owner
   belongs_to :user
   belongs_to :list

   def self.find_default_list(user_id)
   		default_list = ListUser.find(:first, :conditions => {:user_id => user_id})
   		if default_list
	   		default_list_id = default_list.list_id
	   	else
	   		default_list_id = nil
	   	end
   end

end
