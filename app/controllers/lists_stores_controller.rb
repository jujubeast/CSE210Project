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
