class ListsController < ApplicationController

	def new
		@list = List.new

		respond_to do |format|
  		format.html #new.html.erb
  		format.json { render :json => @list}
  	end
	end

	def create
    	@list = List.new(params[:list])

      respond_to do |format|
     	if @list.save
          @list_user = @list.lists_users.create(:user_id => session[:user_id])
        	format.html { redirect_to "/users/#{session[:user_id]}/#{@list.id}", :notice => 'List was successfully created.' }
        	format.json { render :json => @list, :status => :created, :location => @list }
      	else
        	#format.html { render :action => "new" }
        	format.json { render :json => @list.errors, :status => :unprocessable_entity }
      	end
    	end
  	end

    def destroy
    @list = List.find(params[:id])
    @list.destroy

    respond_to do |format|
      format.html { redirect_to "/users/#{session[:user_id]}" }
      format.json { head :no_content }
    end
  end
end
