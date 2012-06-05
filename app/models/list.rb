class List < ActiveRecord::Base
  attr_accessible :name, :privacy
  
  # map list and user relation by using list_users
  has_many :list_users
  has_many :users, :through => :list_users
  
  # map list and store relation by using list_storess
  has_many :list_stores
  has_many :stores, :through => :list_stores
end
