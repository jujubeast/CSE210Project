class StoreEntity
  def initialize
    @store = nil
  end
  
  def find_by_id(store_id)
    @store = Store.find(store_id)
  end
  
  def store
    @store
  end
  
  def addreview(user_id, review_category, tag_title)
    cat = Category.where(:category => review_category).first_or_create()
    tag = cat.tags.where(:name => tag_title).first_or_create()
    tag.store_tag_users.where(:user_id => user_id, :store_id => @store.id).first_or_create()
  end
  
#  def removereview(user_id, review_category, tag_title)
#    cat = Category.where(:category => review_category)
#    tag = cat.tags.where(:name => tag_title).first_or_create()
#    tag.store_tag_users.where(:user_id => user_id, :store_id => @store.id).first_or_create()
#  end
  
  def find_store_review
    store_id = @store.id
    
    store_review = StoreReview.new
    Category.all.each do |c|
      store_review.add_category(c.category)
      storetagusers = StoreTagUser.joins(:tag => :category).select("name, count(*) as tag_num").where("category = ? and store_id = ?",c.category, store_id).group("tag_id,name").order("tag_num DESC")
      storetagusers.each do |s|
        store_review.add_tag(c.category, s.name)
      end
    end
    
    return store_review
  end    
  
  def find_user_store_review(user_id)
    store_id = @store.id
    user_store_review = StoreReview.new
    
    Category.all.each do |c|
      user_store_review.add_category(c.category)
      storetagusers = StoreTagUser.joins(:tag => :category).select("name, count(*) as tag_num")\
                                  .where("category = ? and store_id = ? and store_tag_users.user_id=?",c.category, store_id, user_id)\
                                  .group("tag_id,name")\
                                  .order("tag_num DESC")

#      storetagusers = StoreTagUser.find(:all, 
#                                        :conditions => [ "user_id = ? and store_id = ? and category_id?", user_id, store_id, c.id],
#                                        :joins => [])
      storetagusers.each do |s|
        user_store_review.add_tag(c.category, s.name)
      end
    end
    
    return user_store_review
  end   
  
  def self.find_all
    all_available_stores = Store.find(:all)
  end
end
