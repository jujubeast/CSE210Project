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
    file_upload = params[:upload]
    fileuploader = FileUploadHelper::ImageFileUploadHandler.new(file_upload)
    fileuploader.save_to_disk
    @disk_path = fileuploader.file_absolute_path
    @tmp_disk_path = fileuploader.tmp_file_absolute_path
    img_processing = ImageProcessingHelper::ImageProcessing.new(@tmp_disk_path, @disk_path)
    img_processing.rescale_image_size
    img_processing.save_back_image
    @store.pic = fileuploader.file_web_path
  	respond_to do |format|
  		if @store.save
  		  format.html {redirect_to show_store_path(@store), :notice => "Store successfully created"}
  		end
  	end
  end

  def show
    store_entity = StoresHelper::StoreEntity.new
    @store = store_entity.find_by_id(params[:id])
    @store_review = store_entity.find_store_review
    
    user_entity = UsersHelper::UserEntity.new
    @user = user_entity.find_by_id(session[:user_id])
    
    #@store = Store.find(params[:id])
    #@user = User.find(session[:user_id])
    #@highlights = {}
    #Category.all.each do |c|
    #  tags = Array.new
    #  storetagusers = StoreTagUser.joins(:tag => :category).select("name, count(*) as tag_num").where("category = ? and store_id = ?",c.category, params[:id]).group("tag_id,name").order("tag_num DESC")
    #  storetagusers.each do |s|
    #    tags.append(s.name)
    #  end 
    #  @highlights[c.category] = tags
    #end
  end
  
  def addreview
    success = true
    user_id = session[:user_id]
    store_id = params[:store_id]
    
    puts "user: " + user_id.to_s + "\n"
    puts "store_id " + store_id.to_s + "\n"
    
    store_entity = StoresHelper::StoreEntity.new
    store_entity.find_by_id(store_id)

    add_review_to_store(store_entity, user_id, "What we like", "like")
    add_review_to_store(store_entity, user_id, "What we dislike:", "dislike")
    add_review_to_store(store_entity, user_id, "Environment", "env")
    add_review_to_store(store_entity, user_id, "Restaurant Type", "type")
    add_review_to_store(store_entity, user_id, "Restaurant Has", "has")
    add_review_to_store(store_entity, user_id, "Good for", "good")
    add_review_to_store(store_entity, user_id, "What we like", "like")

    #i = 1
    #tag_name = "like#{i}"
    #puts "index: "  + tag_name + "\n"
    #while check_param_value_exists(tag_name) do
    #  t = params[tag_name]
    #  puts "Review: " + t + "\n"
    #  store_entity.addreview(user_id, "What we like", t)
    #  i += 1
    #  tag_name = "like#{i}"
    #end
  
    respond_to do |format|
      if success
        format.html {redirect_to  show_store_path(store_id), :notice => "reviews successfully created"}
      end
    end
  end
  
  private
  def check_param_value_exists(tag_name)
      t = params[tag_name]
      return (t != nil and !t.empty?)
  end
  
  def add_review_to_store(store_entity, user_id, category_name, param_name_prefix)
    i = 1
    tag_name = param_name_prefix + "#{i}"
    puts "index: "  + tag_name + "\n"
    while check_param_value_exists(tag_name) do
      t = params[tag_name]
      puts "Review: " + t + "\n"
      store_entity.addreview(user_id, category_name, t)
      i += 1
      tag_name = param_name_prefix + "#{i}"
    end
  end
end
