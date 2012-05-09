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
        	format.html { redirect_to default_home_path(session[:user_id], @list.id), :notice => 'List was successfully created.' }
          format.json { render :json => @list, :status => :created, :location => @list }
      	else
        	#format.html { render :action => "new" }
        	format.json { render :json => @list.errors, :status => :unprocessable_entity }
      	end
    	end
  	end

    def add
        @list = List.find(params[:list_id])

        respond_to do |format|
          @lists_store = @list.lists_stores.create(:store_id => params[:store_id])
          format.html { redirect_to default_home_path(session[:user_id], @list.id), :notice => 'List successfully edited'}
          format.json { render :json => @list, :status => :edited, :location => @list}
        end
    end

    def remove
        @list = List.find(params[:list_id])

        respond_to do |format|
          @lists_store = @list.lists_stores.destroy()
          default_list_id = ListsUser.find_default_list(session[:user_id])
          format.html { redirect_to default_home_path(session[:user_id], default_list_id), :notice => 'List successfully edited'}
          format.json { render :json => @list, :status => :edited, :location => @list}
        end
    end

    def destroy
    @list = List.find(params[:id])
    @list.destroy
    default_list_id = ListsUser.find_default_list(session[:user_id])

    respond_to do |format|
      if default_list_id
        format.html { redirect_to default_home_path(session[:user_id], default_list_id) }
        format.json { head :no_content }
      else
        format.html { redirect_to home_path(session[:user_id]) }
        format.json { head :no_content }
      end

    end
  end
end
