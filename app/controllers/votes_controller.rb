class VotesController < ApplicationController
  def create
    begin
      vote_manager.publish!
      
      flash[:success] = "Your vote has been recorded."
      redirect_to root_path
    rescue ActiveModel::ValidationError
      @error = "Something went wrong with the input!"
      render "home/index", status: 406
    end
  end

  private
  
  def vote_params
    params.permit(:first_name, :last_name, :birth_date, :vote)
  end
  
  def vote_manager
    load 'vote_manager.rb'
    VoteManager.new(vote_params)
  end
end