class StoresController < ApplicationController
  def new
  	@store = Store.new

  	respond_to do |format|
  		format.html
  		format.json {render :json => @store}
  	end
  end

  def create
  	@store = Store.new(params[:store])

  	respond_to do |format|
  		if @store.save
  			format.html {redirect_to "/users/#{session[:user_id]}", :notice => "Store successfully created"}
  			format.json { render :json => @list, :status => :created, :location => @list }
      	else
        	format.html { render :action => "new" }
        	format.json { render :json => @list.errors, :status => :unprocessable_entity }
  		end
  	end
  end

end
