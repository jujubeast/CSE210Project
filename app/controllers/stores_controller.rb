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

    if (params[:upload] != nil and params[:upload].size > 0)
      file_upload = params[:upload]

      puts "==============="
      puts file_upload
      fileuploader = FileUpload.new(file_upload)
      fileuploader.save_to_disk
      @disk_path = fileuploader.file_absolute_path
      @tmp_disk_path = fileuploader.tmp_file_absolute_path
      img_processing = ImageProcessing.new(@tmp_disk_path, @disk_path)
      img_processing.rescale_image_size
      img_processing.save_back_image
      @store.pic = fileuploader.file_web_path
    end
    respond_to do |format|
      if @store.save
        format.html {redirect_to show_store_path(@store), :notice => "Store successfully created"}
      end
    end
  end

  def show
    store_entity = StoreEntity.new
    @store = store_entity.find_by_id(params[:id])
    @store_review = store_entity.find_store_review
    @store_user_review = store_entity.find_user_store_review(session[:user_id])

    user_entity = UserEntity.new
    @user = user_entity.find_by_id(session[:user_id])
  end

  def addreview
    user_id = session[:user_id]
    store_id = params[:store_id]

    store_entity = StoreEntity.new
    @store = store_entity.find_by_id(store_id)

    store_entity.addreview(user_id, params["category"], params['tag_value'])

    @store_review = store_entity.find_store_review
    @store_user_review = store_entity.find_user_store_review(session[:user_id])

    respond_to do |format|
      format.html {render :partial=>"tags_and_reviews.html.erb",
        :locals => {
          :store_user_review=>@store_user_review,
          :store_review =>@store_review,
          :store=>@store
        }}
    end
  end

  def view_tags
    user_id = session[:user_id]
    store_entity = StoreEntity.new

    @store = store_entity.find_by_id(params[:store_id])
    @store_review = store_entity.find_store_review

    user_entity = UserEntity.new
    @user = user_entity.find_by_id(session[:user_id])
    respond_to do |format|
      format.html {render :partial=>"modal_top_tags.html.erb",
        :locals => {
          :store_review =>@store_review,
          :store=>@store
        }}
    end
  end

  def add_tags
    user_id = session[:user_id]
    store_entity = StoreEntity.new

    @store = store_entity.find_by_id(params[:store_id])
    @store_user_review = store_entity.find_user_store_review(session[:user_id])

    user_entity = UserEntity.new
    @user = user_entity.find_by_id(session[:user_id])
    respond_to do |format|
      format.html {render :partial=>"modal_my_tags.html.erb",
        :locals => {
          :store_user_review=>@store_user_review,
          :store=>@store
        }}
    end
  end

  #  def removereview
  #    user_id = session[:user_id]
  #    store_id = params[:store_id]
  #    store_entity = StoreEntity.new
  #    @store = store_entity.find_by_id(store_id)
  #
  #    store_entity.addreview(user_id, params["category"], params['tag_value'])
  #
  #    @store_review = store_entity.find_store_review
  #    @store_user_review = store_entity.find_user_store_review(session[:user_id])
  #
  #    respond_to do |format|
  #      format.html {render :partial=>"tags_and_reviews.html.erb",
  #        :locals => {
  #          :store_user_review=>@store_user_review,
  #          :store_review =>@store_review,
  #          :store=>@store
  #        }}
  #    end
  #  end

end
