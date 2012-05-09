class ListsStoresController < ApplicationController
	def create
		@lists_store = ListsStore.new
		respond_to do |format|
      	if @lists_store.save
        	#format.html { redirect_to '/', :notice => 'List was successfully created.' }
        	#format.json { render :json => @lists_user, :status => :created, :location => @lists_user }
      	else
        	format.html { render :action => "new" }
        	format.json { render :json => @lists_user.errors, :status => :unprocessable_entity }
      	end
    end
  end
    def destroy
      lists_store = ListsStore.find(:all,
                                    :conditions => { :store_id => params[:store_id], 
                                                     :list_id => params[:list_id]
                                                    })
      
      lists_store.each { |store| store.delete}

      respond_to do |format|
        format.html { redirect_to default_home_path(session[:user_id], params[:list_id]) }
        format.json { head :no_content }
      end
    end
end
