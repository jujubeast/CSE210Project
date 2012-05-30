module UsersHelper
  class UserEntity
    def initialize(user_id)
      @user = User.find(user_id)
    end
    
    def user
      @user
    end
    
    def users_store_lists
      store_list = Array.new
      @user.list_users do
        |user_list|
        store_list.push(user_list.list)
      end
      store_list
    end
  end
end
