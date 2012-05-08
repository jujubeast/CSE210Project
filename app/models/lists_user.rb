class ListsUser < ActiveRecord::Base
   attr_accessible :user_id, :list_id, :owner
   belongs_to :user
   belongs_to :list

   #find list ids based on id of owner user
   def self.find_list_ids(user_id)
    lists_ids = self.find(:all,
                                :conditions => {:user_id => user_id},
                                :select => "list_id").map {|x| x.list_id}
   end

end
