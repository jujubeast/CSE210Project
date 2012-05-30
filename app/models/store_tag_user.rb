class StoreTagUser < ActiveRecord::Base
  attr_accessible :store_id, :tag_id, :user_id
  belongs_to :tag
  belongs_to :store
  def self.find_store_ids_by_ids(tag_ids, excluded_store_ids)
    if tag_ids == nil or tag_ids.size <= 0
      return Array.new
    end
    
    search_criteria = "tag_id in ("
    search_criteria = search_criteria + tag_ids.map(&:id).join(",") + ")"
    if (excluded_store_ids != nil and excluded_store_ids.size > 0)
      search_criteria =
        search_criteria + " and store_id not in (" + excluded_store_ids.map(&:id).join(",") + ")"
    end
    
    store_ids = StoreTagUser.where(
      search_criteria
    ).select("store_id").all
  end

end