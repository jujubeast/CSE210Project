module UsersHelper
  class UserEntity
    def initialize
      @user = nil
    end
    
    def user
      @user
    end
    
    def find_by_id(user_id)
      @user = User.find(user_id)
    end

    def authenticate_by_email(user_email, password)
      @user = User.find(:all, :conditions => ["email=? and password=?", user_email, password]).first
    end

    def authenticate_by_fb_id(user_fb_id, password)
      @user = User.find(:all, :conditions => ["fb_id=? and password=?", user_fb_id, password]).first
    end
    
    def add_new_list(new_list)
      #puts " ***************** add_new_list\n"
      new_list_user = ListUser.new
      new_list_user.privilege = 0
      new_list_user.list = new_list
      @user.list_users.push(new_list_user)
      @user.save
      #puts " ***************** add_new_list -- end\n"
    end

    def users_store_lists
      #puts " ***************** users_store_lists\n"
      store_list = Array.new
      #puts " ***************** num lists: " + @user.list_users.size.to_s + "\n"
      
      @user.list_users.each do
        |user_list|
        #puts " ***************** test list iteration\n"
        store_list.push(user_list.list)
      end
      #puts " ***************** users_store_lists -- end\n"
      store_list
    end
  end
end