class StoreReview
  # This is a non-db data model object. It is used for containing data
  # for displaying the categories and tags.
  
  private
    @store_review = nil
    @categories = nil
  
  public
  def initialize
    @store_review = Hash.new
    @categories = Array.new
  end
  
  def add_category(category_name)
    @categories.append(category_name)
  end

  def all_categories
    @categories
  end

  def add_tag(category_name, tag_name)
    if !@store_review.has_key?(category_name)
      @store_review[category_name] = Array.new
    end
    @store_review[category_name].append(tag_name)
  end
  
  def find_tags(category_name)
    if @store_review.has_key?(category_name)
      return @store_review[category_name]
    else
      return Array.new
    end
  end
end
