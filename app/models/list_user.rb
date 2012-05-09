class ListUser < ActiveRecord::Base
   attr_accessible :user_id, :list_id, :owner
   belongs_to :user
   belongs_to :list

   #find list ids based on id of owner user
   def self.find_list_ids(user_id)
    lists_ids = self.find(:all,
                                :conditions => {:user_id => user_id},
                                :select => "list_id").map {|x| x.list_id}
   end

   def self.find_default_list(user_id)
   		default_list = ListUser.find(:first, :conditions => {:user_id => user_id})
   		if default_list
	   		default_list_id = default_list.list_id
	   	else
	   		default_list_id = nil
	   	end
   end

end
