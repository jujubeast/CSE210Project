class ListsUsers < ActiveRecord::Base
  attr_accessible :list_id, :owner, :user_id
end