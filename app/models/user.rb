class User < ActiveRecord::Base
  attr_accessible :fb_id, :email, :first_name, :last_name, :picture_link, :password
  
  # map user and store association through user_stores
  has_many :store_users
  has_many :stores, :through => :store_users
  
  # map user and list through list_user
  has_many :list_users
  has_many :lists, :through => :list_users
  
  # map tag, user, and store relationship
  has_many :store_tag_users

  #map friend to this user
  has_many :friends
end
