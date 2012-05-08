class ListsUsersController < ApplicationController

	def new
		@list_user = ListsUser.new
		respond_to do |format|
  			format.html #new.html.erb
  			format.json { render :json => @lists_user}
  		end
	end

	def create
		@lists_user = ListsUser.new
		respond_to do |format|
      	if @lists_user.save
        	#format.html { redirect_to '/', :notice => 'List was successfully created.' }
        	#format.json { render :json => @lists_user, :status => :created, :location => @lists_user }
      	else
        	format.html { render :action => "new" }
        	format.json { render :json => @lists_user.errors, :status => :unprocessable_entity }
      	end
    end


end
