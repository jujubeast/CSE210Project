class Friend < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :user_id, :friend_id

  belongs_to :users
end
