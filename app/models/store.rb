class Store < ActiveRecord::Base
	has_many :lists_stores
	has_many :lists, :through => :lists_stores
  	attr_accessible :been_to, :can_delete, :detail_info, :favorite, :image, :name
end
