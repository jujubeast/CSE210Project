class UsersController < ApplicationController
  def new
  	@user = User.new

  	respond_to do |format|
  		format.html #new.html.erb
  		format.json { render :json => @user}
  	end
  end

  def create
    @user = User.new(params[:user])
    
    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to "/users/#{@user.id}", :notice => 'User was successfully created.' }
        format.json { render :json => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def show
    @user = User.find(params[:id])
    @lists_ids = ListsUser.find(:all,
                                :conditions => ["user_id = ?", params[:id]],
                                :select => "list_id").map {|x| x.list_id}

    @lists = List.find(:all,
                        :conditions => ["id IN (?)", @lists_ids],
                        :select => "name, id")

    if params[:cur_list]
    @stores_ids = ListsStore.find(:all,
                         :conditions => ["list_id = ?", params[:cur_list]],
                         :select => "store_id").map {|x| x.store_id}

    @stores = Store.find(:all,
                         :conditions => ["id IN (?)", @stores_ids],
                         :select => "name, id")
  end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end
end
