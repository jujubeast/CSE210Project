class SimpleSearchController < ApplicationController
  def search
    search_val = params[:searchfor]
    search_op = SimpleSearchOperation.new(search_val)
    search_op.do_search
    @view_data = search_op.view_data
    @user = User.find(session[:user_id])
  end

  def show
    @friends = User.find(session[:user_id])
  end

  def search_advanced
    puts 'IN SEARCH_ADVANCED #####'
    @friends = User.find(:all) #mock friends (actually just users in the database)

    #    @friends_list = Hash.new               #all the "lists" of the friends.
    #    for friend in @friends do
    #       @friends_list[friend.id] = List.find_users_lists(friend.id)
    #    end
    render :partial=>"simple_search/advanced_search_bar", :locals=>{ :friends=>@friends }  
  end
  
  def get_list
    @friend = User.find(params[:friend_id].split(".")[1])
    @list = List.find_users_lists(@friend.id)
    render :partial=>"simple_search/list_selection", :collection => @list, :locals => { :friend => @friend }
  end
  
  def approve_tag
    #check to see if params[:tag_value] matches any tag that is in the database
    #if matches, return tag object. 
    @tag = Tag.new()
    @tag.name = "test"
    @tag.id = 1
    #if tag does not exist, don't return a tag. 
    render :partial=>'simple_search/approved_tag', :locals => { :tag => @tag }
  end 
end