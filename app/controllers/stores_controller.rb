class StoresController < ApplicationController
  def new
  	@store = Store.new
  	@user = User.find(session[:user_id])
  	respond_to do |format|
  		format.html
  		format.json {render :json => @store}
  	end
  end

  def create
  	@store = Store.new(params[:store])
#  	@user = User.find(session[:user_id])

  	respond_to do |format|
  		if @store.save
  		  format.html {redirect_to show_store_path(@store), :notice => "Store successfully created"}
 #   		format.html {redirect_to home_path(session[:user_id]), :notice => "Store successfully created"}
 # 	 	  format.json { render :json => @list, :status => :created, :location => @list }
      	else
  #      	format.html { render :action => "new" }
  #      	format.json { render :json => @list.errors, :status => :unprocessable_entity }
  		end
  	end
  end
  def show
    @store = Store.find(params[:id])
    @user = User.find(session[:user_id])
    @highlights = {}
    Category.all.each do |c|
      tags = Array.new
      storetagusers = StoreTagUser.joins(:tag => :category).select("name, count(*) as tag_num").where("category = ? and store_id = ?",c.category, params[:id]).group("tag_id,name").order("tag_num DESC")
      storetagusers.each do |s|
        tags.append(s.name)
      end 
      @highlights[c.category] = tags
    end
  end
  def addreview
    success = true
    user_id = session[:user_id]
#    user_id = params[:user_id]
    store_id = params[:store_id]
    i = 1
    category_name = "What we like"
    category = Category.where(:category => category_name).first_or_create()
    while i <= params[:like].to_i do
      
      tag_name =  "like#{i}"
      t = params[tag_name]
      if t.empty?
        i += 1
        next
      end
      tag = category.tags.where(:name => t).first_or_create()
      storeTagUser = tag.store_tag_users.where(:user_id => user_id,:store_id => store_id).create()
      i += 1
   end
   category.save
   i = 1
   category_name = "What we dislike"
   category = Category.where(:category => category_name).first_or_create()
   while i <= params[:dislike].to_i do
     tag_name =  "dislike#{i}"
     t = params[tag_name]
     if t.empty?
       i += 1
       next
     end
     tag = category.tags.where(:name => t).first_or_create()
     storeTagUser = tag.store_tag_users.where(:user_id => user_id,:store_id => store_id).create()
     i += 1
   end
   category.save
   i = 1
   category_name = "Environment"
   category = Category.where(:category => category_name).first_or_create()
   while i <= params[:env].to_i do
     tag_name =  "env#{i}"
     t = params[tag_name]
     if t.empty?
       i += 1
       next
     end     
     tag = category.tags.where(:name => t).first_or_create()
     storeTagUser = tag.store_tag_users.where(:user_id => user_id,:store_id => store_id).create()
     i += 1
   end
   category.save
   i = 1
   category_name = "Restaurant Type"
   category = Category.where(:category => category_name).first_or_create()
   while i <= params[:type].to_i do
     tag_name =  "type#{i}"
     t = params[tag_name]
     if t.empty?
       i += 1
       next
     end
     tag = category.tags.where(:name => t).first_or_create()
     storeTagUser = tag.store_tag_users.where(:user_id => user_id,:store_id => store_id).create()
     i += 1
   end  
   category.save 
   i = 1
   category_name = "Restaurant Has"
   category = Category.where(:category => category_name).first_or_create()
   while i <= params[:has].to_i do
     tag_name =  "has#{i}"
     t = params[tag_name]
     if t.empty?
       i += 1
       next
     end
     tag = category.tags.where(:name => t).first_or_create()
     storeTagUser = tag.store_tag_users.where(:user_id => user_id,:store_id => store_id).create()
     i += 1
   end  
   category.save   
   i = 1
   category_name = "Good for"
   category = Category.where(:category => category_name).first_or_create()
   while i <= params[:good].to_i do
     tag_name =  "good#{i}"
     t = params[tag_name]
     if t.empty?
       i += 1
       next
     end
     tag = category.tags.where(:name => t).first_or_create()
     storeTagUser = tag.store_tag_users.where(:user_id => user_id,:store_id => store_id).create()
     i += 1
   end         
   category.save
#    @highlights = params[:highlights]
#    @highlights.each do |category_name, tags|
#      category = Category.where(:category => category_name).first_or_create()
#      tags.each do |t|
#        tag = category.tags.where(:name => t).first_or_create()
#        storeTagUser = tag.store_tag_users.where(:user_id => user_id,:store_id => store_id).create()
#      end
#      if (!category.save)
#      success = false
#      break
#      end
#    end

#    redirect_to :action => "addreview", :store_id => store_id
    respond_to do |format|
      if success
        format.html {redirect_to  show_store_path(store_id), :notice => "reviews successfully created"}
#       format.html {redirect_to home_path(session[:user_id]), :notice => "Store successfully created"}
#       format.json { render :json => @list, :status => :created, :location => @list }
        else
  #       format.html { render :action => "new" }
  #       format.json { render :json => @list.errors, :status => :unprocessable_entity }
      end
    end    
  end
end
