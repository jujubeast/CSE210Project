class SessionsController < ApplicationController

	def new
	end

	def create
	  #puts "1. \n"
	  user_entity = UsersHelper::UserEntity.new
	  user = user_entity.authenticate_by_email( \
	    params[:session][:email], \
	    params[:session][:password] \
	  )
    #puts "2. authenticate by email\n"
	  if !user.nil?
	    user_id = user.id
      #puts "3. user id " + user_id.to_s + "\n"
	    session[:user_id] = user_id
	    
	    if !user.list_users.nil? and user.list_users.size > 0
        #puts "4. get default list\n"
	      default_list_id = user.list_users[0].list.id
        #puts "5. list id " + default_list_id.to_s + "\n"
	      redirect_to default_home_path(user_id, default_list_id)
	    else
        #puts "6.  no default list\n"
	      redirect_to home_path(user_id)
	    end
	  else
      #puts "7.  error\n"
      flash.now[:error] = 'Invalid login information'
      redirect_to "/"
	  end
	end

	def destroy
		session[:user_id] = nil
		redirect_to "/"
	end

end
