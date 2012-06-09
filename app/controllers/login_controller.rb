require 'rubygems'
require 'json'
require 'net/https'
require 'uri'

class LoginController < ApplicationController

  def show
   @link = '\'homepage\''
   render 'login/index'
  end
  
  def login
    fb_user = FbGraph::User.me(params[:access_token])
    fb_user = fb_user.fetch
  
    if !User.exists?(:fb_id => fb_user.identifier)
      registered_user = User.new
      registered_user.fb_id = fb_user.identifier
      registered_user.save
    
      ListLogic.create_default_lists(registered_user.id)
      #@response = 'Congratulations! You are now a user of myHangoutss'
    end
    
    user = User.where(:fb_id => fb_user.identifier).first
    user.first_name = fb_user.first_name
    user.last_name = fb_user.last_name
    user.email = fb_user.email
    user.fb_id = fb_user.identifier
    user.picture_link = fb_user.picture(size = 'large') #not sure about this
    user.save
    
    
    print '\n *********** Printing picture link : *********** \n'
    print user.picture_link
    
    id = user.id
    session[:user_id] = id
    session[:access_token] = params[:access_token]

    friends_list = getFriendsList()

    SearchLogic.update_friends_table(friends_list, id)

   # puts "FRIENDSSSSSSSSSERGHERD"
   # friends_list.each do |friend|
   #   puts friend.identifier.to_s
   # end
    
    redirect_to('/users/' + id.to_s, :session => session)
  end
  
  def getFriendsList
    user = FbGraph::User.me(params[:access_token])
    user = user.fetch
    friends_list = user.friends
    #friends_list.each do |friend|
    #  print friend.identifier
    #  print "\n"
    #end
  end

end

