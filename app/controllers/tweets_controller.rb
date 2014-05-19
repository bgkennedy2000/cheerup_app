class TweetsController < ApplicationController

  def create
    @cheerup = Cheerup.find(params[:tweet][:cheerup_id].to_i)
    @cheerup.tweet
    redirect_to @cheerup, notice: 'Tweet sent.' 
  end

 
end