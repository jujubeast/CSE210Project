class User < ActiveRecord::Base
	has_many :lists_users
	has_many :lists, :through => :lists_users
  	attr_accessible :email, :first_name, :last_name, :picture_link, :password
end
