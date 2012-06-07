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
    current_user_id = session[:user_id]
    if (defined? current_user_id)
      if (current_user_id != params[:id])
        params[:id] = current_user_id
      end
    end

    user_entity = UserEntity.new
    user_entity.find_by_id(params[:id])
    @user = user_entity.user
    @lists = user_entity.users_store_lists

    if params[:cur_list]
      list_entity = ListEntity.new(params[:cur_list])
      @current_list = list_entity.current_list
      @stores = list_entity.associated_stores
      puts @stores
    else
      if @lists != nil and @lists.size > 0
        list_entity = ListEntity.new(@lists[0].id)
        @current_list = list_entity.current_list
        @stores = list_entity.associated_stores
      end
    end
    
    @available_stores = StoreEntity.find_all
    @available_stores.each do |store|
      print store.name + "\n"
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end
end
