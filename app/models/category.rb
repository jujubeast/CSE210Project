class Category < ActiveRecord::Base
  has_many :tags
  attr_accessible :category
end
