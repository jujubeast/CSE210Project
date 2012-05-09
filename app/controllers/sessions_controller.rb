class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by_email(params[:session][:email])
		default_list_id = ListsUser.find_default_list(user.id)
		if user && user.password == params[:session][:password] 
			session[:user_id] = user.id
			
			if default_list_id
				redirect_to default_home_path(session[:user_id], default_list_id)
			else
				redirect_to home_path(session[:user_id])
			end
		else
			flash.now[:error] = 'Invalid login information'
			redirect_to "/"
		end

		#else
		#	flash.now[:error] = 'Invalid email/password combination'
		#	render 'new'
		#end
	end

	def destroy
		session[:user_id] = nil
		redirect_to "/"
	end

end
