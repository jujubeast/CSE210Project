class User < ActiveRecord::Base
	has_many :list_users
	has_many :lists, :through => :list_users
  attr_accessible :email, :first_name, :last_name, :picture_link, :password, :fb_id
  # attr_accessor :first_name, :last_name, :email, :password, :picture_link, :fb_id
  
  validate :fb_id, :allow_blank => true

end
