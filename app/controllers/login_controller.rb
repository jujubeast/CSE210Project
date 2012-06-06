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
    user = FbGraph::User.me(params[:access_token])
    user = user.fetch
  
    if User.exists?(:fb_id => user.identifier)
      @response = user.identifier
    else
      registered_user = User.new
      registered_user.first_name = user.first_name
      registered_user.last_name = user.last_name
      registered_user.email = user.email
      registered_user.fb_id = user.identifier
      registered_user.picture_link = user.link #not sure about this
      registered_user.save

      ListLogic.create_default_lists(registered_user.id)
      #@response = 'Congratulations! You are now a user of myHangoutss'
    end
    
    user = User.where(:fb_id => user.identifier).first
    id = user.id
    
    session[:user_id] = id
    session[:access_token] = params[:access_token]
    
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

