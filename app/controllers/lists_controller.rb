class ListsController < ApplicationController
  respond_to :js

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
          @list_user = @list.list_users.create(:user_id => session[:user_id])
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
          @list_store = @list.list_stores.create(:store_id => params[:store_id])
          format.html { redirect_to default_home_path(session[:user_id], @list.id), :notice => 'List successfully edited'}
          format.json { render :json => @list, :status => :edited, :location => @list}
        end
    end

    def remove
        @list = List.find(params[:list_id])

        respond_to do |format|
          @list_store = @list.list_stores.destroy()
          default_list_id = ListUser.find_default_list(session[:user_id])
          format.html { redirect_to default_home_path(session[:user_id], default_list_id), :notice => 'List successfully edited'}
          format.json { render :json => @list, :status => :edited, :location => @list}
        end
    end

    def destroy
    @list = List.find(params[:id])
    @list.destroy
    default_list_id = ListUser.find_default_list(session[:user_id])

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

  #display lists on store drop down menu
  def show_curr_lists
      @curr_lists = List.find_lists_by_curr_store(params[:store_id], session[:user_id])

      if(@curr_lists.empty?)
          @not_on_lists = List.find_users_lists(session[:user_id])
      else
          list_names = Array.new
          @curr_lists.each do |list|
            list_names.push(list.name)
          end
          @not_on_lists = List.find_all_other_lists(list_names, session[:user_id])
      end

      @store_id = params[:store_id]

      respond_to do |format|
        format.html {redirect_to home_path(session[:user_id])}
        format.js
      end
  end

  def show_possible_lists
      @curr_lists = List.find_lists_by_curr_store(params[:store_id], session[:user_id])

      @store_id = params[:store_id]

      respond_to do |format|
        format.html {redirect_to home_path(session[:user_id])}
        format.js
      end 
  end

end
