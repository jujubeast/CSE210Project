class Store < ActiveRecord::Base
  attr_accessible :name, :detail_info, :pic, :street_1, :street_2, :city, :state, :zipcode, :telephone, :website, :hours
  
  # map store and user associations through store_user
  has_many :store_users
  has_many :users, :through => :store_users

  # map list and store associations through list_stores
  has_many :list_stores
  has_many :lists, :through => :list_stores
  
  # map tag, user, and store relationship
  has_many :store_tag_users
end