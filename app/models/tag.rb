class Tag < ActiveRecord::Base
  attr_accessible :category_id, :name
  
  def self.find_id_by_fuzzy_match(search_string)
    stores = Tag.where(
      "name like ?", search_string
    ).select("id").all
  end

end