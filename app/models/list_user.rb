class ListUser < ActiveRecord::Base
  attr_accessible :user_id, :list_id, :privilege
  
  # used to map the user and list relation.
  belongs_to :user
  belongs_to :list
end
