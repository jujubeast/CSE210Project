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
  
  def add_new_list(new_list, privilege)
    #puts " ***************** add_new_list\n"
    new_list_user = ListUser.new
    new_list_user.privilege = privilege
    new_list_user.list = new_list
    @user.list_users.push(new_list_user)
    @user.save
    #puts " ***************** add_new_list -- end\n"
  end

  def find_user_default_list
    if @user.list_users != nil and @user.list_users.size > 0
      default_list_id =  @user.list_users[0].list.id
      #puts "default list id: " + default_list_id.to_s + "\n"  
      return default_list_id
    else
      return nil        
    end  
  end

  def delete_user_list(list_id)
    list = List.find(list_id)

    #this will destroy all list_users and list_stores items associated with this list
    #because of :dependent => :destroy in model associations
    list.destroy
  end
  
  def users_store_lists
    #puts " ***************** users_store_lists\n"
    store_list = Array.new
    @user.list_users.each do |user_list|
      store_list.push(user_list.list)
    end
    #puts " ***************** users_store_lists -- end\n"
    store_list
  end
end
