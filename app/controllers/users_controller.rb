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
    puts @user.first_name()
    puts @user.email()
    puts @user.password()
    puts "true" if @user.valid?
    
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
    @user = User.find(params[:id])
    @lists = List.find_users_lists(params[:id])

    if params[:cur_list]
      @stores = Store.find_stores_by_ids(params[:cur_list])
      @current_list = List.find(params[:cur_list])
    end

    @available_stores = Store.find(:all)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end
end
