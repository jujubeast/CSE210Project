class Category < ActiveRecord::Base
  attr_accessible :category

  # map the category and tag relationship, many to many  
  has_and_belongs_to_many :tags
end