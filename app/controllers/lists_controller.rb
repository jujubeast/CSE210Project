class ListsController < ApplicationController
  respond_to :js

	def new
		list = ListLogic.create_new_list(nil)
    friends = FriendLogic.find_friends(session[:user_id])
    user = User.find_by_id(session[:user_id])
	  render :partial => "lists/new", :locals => {:friends => friends, :list => list, :user => user}
	end

	def create
      @list = ListLogic.create_new_list(params[:list])
      @list.deletable = true
      respond_to do |format|
        if @list.save
          # get curent user
          user_id = session[:user_id]
          user_entity = UserEntity.new
          user_entity.find_by_id(user_id)
          user_entity.add_new_list(@list, 0)

          #set up permissions for friends of creating user
          params.each do |parameter|
            if parameter[0].starts_with? 'friend'
                user_entity.find_by_id(parameter[0].split('.')[1])
                user_entity.add_new_list(@list, 1)
            end
          end

          format.html { redirect_to default_home_path(session[:user_id], @list.id), :notice => 'List was successfully created.' }
          format.json { render :json => @list, :status => :created, :location => @list }
        else
          #format.html { render :action => "new" }
          format.json { render :json => @list.errors, :status => :unprocessable_entity }
        end
      end
  	end

    def add
        #@list = List.find(params[:list_id])
        list_id = params[:list_id]
        store_id = params[:store_id]
        list_entity = ListEntity.new(list_id)
        
        respond_to do |format|
          @list_store = list_entity.add_store_to_current_list(store_id)
          puts list_id
          puts store_id
          puts "#*********#"
          puts @list_store.store.name
          
          format.html { redirect_to default_home_path(session[:user_id], list_id), :notice => 'List successfully edited'}
          format.json { render :json => @list, :status => :edited, :location => @list}
        end
    end

    def destroy
      list_id = params[:id]

      if ListLogic.check_deletable(list_id)
        user_id = session[:user_id]
        user_entity = UserEntity.new
        user_entity.find_by_id(user_id)
        user_entity.delete_user_list(list_id)
      end
      
      # after delete, you need to reload the list so create
      # the new user which reload the list by default.
      user_entity2 = UserEntity.new
      user_entity2.find_by_id(user_id)
      default_list_id = user_entity2.find_user_default_list
      #default_list_id = ListUser.find_default_list(session[:user_id])

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
  def show_possible_lists
      @curr_lists = ListFinder.find_lists_by_curr_store(params[:store_id], session[:user_id])

      if(@curr_lists.empty?)
          @not_on_lists = ListFinder.find_users_lists(session[:user_id])
      else
          list_names = Array.new
          @curr_lists.each do |list|
            list_names.push(list.name)
          end
          @not_on_lists = ListFinder.find_all_other_lists(list_names, session[:user_id])
      end

      @store_id = params[:store_id]
    render :partial => "lists/show_possible_lists", :locals => {:store_id => @store_id}
  end

  def show_curr_lists

      @curr_lists = ListFinder.find_lists_by_curr_store(params[:store_id], session[:user_id])
      @store_id = params[:store_id]

    render :partial => "lists/show_curr_lists", :locals=>{:curr_lists => @curr_lists, :store_id =>@store_id}
  end

  #return list of lists that this store belongs to, and owner of those lists
  def show_curr_listers

    @curr_lists = ListFinder.find_listers(params[:lists], params[:store_id])
    render :partial => "lists/show_curr_listers"
  
  end

end
