class ListController < ApplicationController

	def new
		@list = List.new

		respond_to do |format|
  		format.html #new.html.erb
  		format.json { render :json => @list}
	end

	def create
    @list = List.new(params[:list])

    respond_to do |format|
      if @list.save
        format.html { redirect_to @list, :notice => 'List was successfully created.' }
        format.json { render :json => @list, :status => :created, :location => @list }
      else
        format.html { render :action => "new" }
        format.json { render :json => @list.errors, :status => :unprocessable_entity }
      end
    end
  end
end
