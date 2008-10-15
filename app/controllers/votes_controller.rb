class VotesController < ApplicationController
  def create
    @idea = Idea.find(params[:idea_id])
    @idea.vote_up
    redirect_to "/#{@idea.poster}"
  end
end
