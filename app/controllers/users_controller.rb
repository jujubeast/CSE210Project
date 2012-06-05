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
    #puts @user.first_name()
    #puts @user.email()
    #puts @user.password()
    #puts "true" if @user.valid?
    
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
    
    #puts "*************** User show\n"

    user_entity = UsersHelper::UserEntity.new
    user_entity.find_by_id(params[:id])
    @user = user_entity.user
    @lists = user_entity.users_store_lists

    #puts "*************** User show step #1\n"

    if params[:cur_list]
    #puts "*************** User show step #2\n"

      list_entity = ListsHelper::ListsEntity.new(params[:cur_list])
      @current_list = list_entity.current_list
      @stores = list_entity.associated_stores
      puts @stores
    else 
      list_entity = ListsHelper::ListsEntity.new(@lists[0].id)
      @current_list = list_entity.current_list
      puts @current_list.name
      @stores = list_entity.associated_stores
    end
    
    @available_stores = StoresHelper::StoreEntity.find_all

    print "HIIIIIIIIIIIII"

    @available_stores.each do |store|
      print store.name + "\n"
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end
end
