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
    render :partial=>"simple_search/advanced_search_bar", :locals=>{:friends=>@friends }  
  end
end