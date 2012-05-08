class List < ActiveRecord::Base
	has_many :lists_users, :dependent => :destroy
	has_many :users, :through => :lists_users
	has_many :lists_stores, :dependent => :destroy
	has_many :stores, :through => :lists_stores
	attr_accessible :can_delete, :name

end
