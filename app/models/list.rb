class List < ActiveRecord::Base
	has_many :list_users, :dependent => :destroy
	has_many :users, :through => :lists_users
	has_many :list_stores, :dependent => :destroy
	has_many :stores, :through => :lists_stores
	attr_accessible :deletable, :name

end
