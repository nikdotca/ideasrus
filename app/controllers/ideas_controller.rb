class IdeasController < ApplicationController
  def index
    if params[:user]
      @ideas = Idea.find_from_twitter_for params[:user]
    else
      @ideas = Idea.find_from_twitter
    end
  end
end
