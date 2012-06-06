class Store < ActiveRecord::Base
	has_many :list_stores
	has_many :store_tag_users
	has_many :lists, :through => :list_stores
  	attr_accessible :been_to, :can_delete, :detail_info, :favorite, :image, :name, :pic,:street_1,:street_2,:city,:state,:zipcode,:telephone,:hours,:website
  	#finds stores given ARRAY of store ids

    include StoreFinder
    
end
