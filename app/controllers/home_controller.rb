class HomeController < ApplicationController
  layout "application"
  def index
  	
  end

  def create
  	vote_manager.publish params
  	flash[:success] = "Your response has been recorded."
  	redirect_back fallback_location: { action: index }
  end

  private
  
  def vote_manager
  	require_dependency 'vote_manager'
  	VoteManager.new
  end
end