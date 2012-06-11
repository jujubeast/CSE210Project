class UsersController < ApplicationController
  def new
  	@user = User.new
  	respond_to do |format|
  		format.html #new.html.erb
  		format.json { render :json => @user}
  	end
  end

  def create
    # XXX Validation???
    
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to home_path(@user.id), :notice => 'User was successfully created.' }
        format.json { render :json => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def show
    # XXX need to verify user_id is valid
    # XXX raise exception and catch, then display error page.
    
    # XXX This is only temporary until the team finds a solution on sharing
    @current_user_id = session[:user_id]
   # if (defined? current_user_id)
    #  if (current_user_id != params[:id])
     #   params[:id] = current_user_id
     # end
    #end

    user_entity = UserEntity.new
    user_entity.find_by_id(params[:id])
    @user = user_entity.user
    lists = user_entity.users_store_lists

    if params[:cur_list]
      list_entity = ListEntity.new(params[:cur_list])
      @current_list = list_entity.current_list
      @stores = list_entity.associated_stores
    else
      if lists != nil and lists.size > 0
        list_entity = ListEntity.new(lists[0].id)
        @current_list = list_entity.current_list
        @stores = list_entity.associated_stores
      end
    end
        
    #split lists array into @users_lists, @group_lists, and @subbed_lists
    @users_lists = Array.new
    @group_lists = Array.new
    @subbed_lists = Array.new

    list_privileges = ListFinder.findListPrivileges(params[:id], lists)

    lists.each do |list|
      if list_privileges[list.id] == 0
        @users_lists.push(list)
      elsif list_privileges[list.id] == 1
        @group_lists.push(list)
      elsif list_privileges[list.id] == 2
        @subbed_lists.push(list)
      end
    end

    @subbed_lists_owners = ListFinder.find_list_owners(@subbed_lists)

    #array of current_user's subbed lists to disable sub button on display of other users pages
    @curr_user_subbed_lists = ListFinder.findUserSubbedLists(session[:user_id])

    @available_stores = StoreEntity.find_all
    @default_list_state = ListFinder.findDefaultListHash(session[:user_id], @stores)
    @friends_list = FriendLogic.find_friends(session[:user_id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end
end
