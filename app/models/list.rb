class List < ActiveRecord::Base
	has_many :list_users, :dependent => :destroy
	has_many :users, :through => :lists_users
	has_many :list_stores, :dependent => :destroy
	has_many :stores, :through => :lists_stores
	attr_accessible :can_delete, :name

	#finds lists to display in views given ARRAY of list ids
	def self.find_lists_by_ids(list_ids)
		lists = List.find(:all,
                        :conditions => ["id IN (?)", list_ids],
                        :select => "name, id")
	end

end
