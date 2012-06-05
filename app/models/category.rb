class Category < ActiveRecord::Base
  attr_accessible :category

  # map the category and tag relationship, many to many  
  has_many :tags
end