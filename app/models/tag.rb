class Tag < ActiveRecord::Base
  attr_accessible :name, :user_id

  # map the category and tag relationship, many to many  
  has_and_belongs_to_many :categories
  
  # map tag, user, and store relationship
  belongs_to :user
  has_and_belongs_to_many :stores
end
