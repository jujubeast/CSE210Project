class Tag < ActiveRecord::Base
  attr_accessible :name, :user_id

  # map tag, user, and store relationship
  has_many :store_tag_users
  belongs_to :category
end
