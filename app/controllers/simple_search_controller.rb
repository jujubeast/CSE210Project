class SimpleSearchController < ApplicationController
  #def search
  #search_string = params[:searchfor]
  #search_op = SimpleSearchOperation.new(search_string)
  #search_op.do_search
  #@view_data = search_op.view_data
  #@user = User.find(session[:user_id])
  #end
  def show
    @friends = User.find(session[:user_id])
  end

  def search

    search_string = params[:searchfor]
    search_lists = Array.new
    tag_lists = Array.new

    params.each do |parameter|
      #param_str = parameter.to_s
      #seems that parameter[0] contains the key, in this case "list.id", where id is some number
      #so we can just parse that
      print parameter[0]
      print "\n"
      if parameter[0][0,5] == "list."
        search_lists.push(parameter[0].split(".")[1].to_s)
      end
      if parameter[0][0,4] == "tag."
        tag_lists.push(parameter[0].split(".")[1].to_s)
      end
    end

    #print "Looking at lists\n"
    #search_lists.each do |list|
    #  print list
    #  print "\n"
    #end
    
    #print "Looking at tags\n"
    #tag_lists.each do |tag|
    #  print tag
    #  print "\n"
    #end

    #search list now contains list of list ids and tag_ids to search over and search_string contains the search text

    #initialize searchResult = null
    searchResult = Array.new
    actualSearchResult = Array.new
    simpleSearch = false

    #store simple search result on search_string
    simpleSearchResult = Store.where("name like ?  or detail_info like ?", "%" + search_string + "%", "%" + search_string + "%").select("id").all

    #print "Printing simpleSearchResult \n"
    #simpleSearchResult.each do |store|
    #    print store.id
    #    print "\n"
    #end

    if(search_lists == []  && tag_lists == [])
      simpleSearch = true
    end

    if simpleSearch == false

      #get a list of stores that belong to any of the lists in search_lists
      search_lists.each do |list|
        listresult = ListStore.find(:all, :conditions => {:list_id => list })
        listresult.each do |store|
        existsInSearch = false
          searchResult.each do |storeInSearch|
            if storeInSearch.store_id == store.store_id
              existsInSearch = true
            end
          end
          if existsInSearch == false
            searchResult.push(store)
          end
        end
      end

      #remove duplicates
      searchResult = searchResult.uniq

      print "Printing searchResults : \n"
      searchResult.each do |st|
          print st.store_id
          print "\n"
      end

      deleteSearchResult = Array.new

      #for each store in searchResult,
      #remove a store if there is no tag associated and
      #search_string is not found either in store_name or in store_description
      #if tag_lists is empty then show all stores from the selected lists.. no need to filter further
      if (!tag_lists.empty?) || (tag_lists.empty? && !search_string.empty?)
        searchResult.each do |store|
            #print "Checking for store "+ store.store_id.to_s + "\n"
            flag = false
    
            # flag = true if some (search) tag is associated with the store
            tag_lists.each do |tag|
              if StoreTagUser.exists?(:store_id => store.store_id, :tag_id => tag)
                #print "flag turned true for " + store.store_id.to_s + " and " + tag.to_s + "\n"
                flag = true
              end
            end
    
            if !search_string.empty?
              # flag = true if the store exists on search result of simple search query on search_string
              simpleSearchResult.each do |st|
                if st.id == store.store_id
                  #print "flag turned true for " + store.store_id.to_s + " for simpleSearch \n"
                  flag = true
                end
              end
            end
    
            # if flag is still false remove store from searchResult
            if flag == false
              #print "deleting store with id = " + store.store_id.to_s + "\n"
              deleteSearchResult.push(store)
            end
          end
        end

      searchResult = searchResult - deleteSearchResult

      searchResult.each do |liststoreobject|
        store = Store.find_by_id(liststoreobject.store_id)
        actualSearchResult.push(store)
      end

    else
      simpleSearchResult.each do |store|
        store = Store.find_by_id(store)
        actualSearchResult.push(store)
      end
    end

    #print "Printing actual search results \n"
    #actualSearchResult.each do |store|
    #  print store.id
    #  print "\n"
    #end

    #return searchResults
    @view_data = actualSearchResult
    @lists = search_lists
    @user_id = session[:user_id]

    @default_list_state = findDefaultListHash(@user_id, @view_data)

    render 'simple_search/search'
  end

  #renders Advanced Search bar with user's friends lists in container
  def search_advanced
    puts 'IN SEARCH_ADVANCED #####'
    @friends = getFriendsList(session[:access_token]) #mock friends (actually just users in the database)
    #@friends = User.find(:all)
    render :partial=>"simple_search/advanced_search_bar", :locals=>{ :friends=>@friends }
  end

  #Retrieves friend's lists when selected
  def get_list
    @friend = User.find(params[:friend_id].split(".")[1])
    @list = ListFinder.find_users_lists(@friend.id)
    render :partial=>"simple_search/list_selection", :collection => @list, :locals => { :friend => @friend }
  end

  #Uses FB API to retrieve friends list
  def approve_tag
    #check to see if params[:tag_value] matches any tag that is in the database
    #if matches, return tag object.
    #puts params[:tag_value]
    if Tag.exists?(:name => params[:tag_value])
      @tag = Tag.where(:name => params[:tag_value]).first
    else
      @tag = nil
    end
    #if tag does not exist, don't return a tag.
    render :partial=>'simple_search/approved_tag', :locals => { :tag => @tag }
  end

  def getFriendsList(access_token)
    #user = FbGraph::User.me(access_token)
    #user = user.fetch
    #friends_list = user.friends
    #Changed to store friend relationships locally so advanced search bar works faster.
    @friends = Array.new
    friends_list = FriendLogic.find_friends(session[:user_id])

    user = UserFinder.find_by_user_id(session[:user_id])
    @friends.push(user)

    friends_list.each do |friend|
      @friends.push(friend)
    end

    @friends
  end

  def findDefaultListHash(user_id, stores)
    default_list_state = Hash.new

    stores.each do |store|
      default_list_state[store.id] = StoreFinder.in_default_lists(user_id, store.id)
    end

    return default_list_state
  end
end