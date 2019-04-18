class HomeController < ApplicationController
  layout "application"
  def index ; end

  def create
    begin
      vote_manager.publish!
  	  flash[:success] = "Your response has been recorded."
    rescue ActiveModel::ValidationError
      @error = "Something went wrong with the input!"
    end
  	render :index
  end

  private
  
  def vote_params
    params.permit(:first_name, :last_name, :birth_date)
    vote = params[:vote_yes] == '1' ? true : false
    params[:vote] = vote
    params
  end
  
  def vote_manager
  	require_dependency 'vote_manager'
  	VoteManager.new(vote_params)
  end
end