class TweetsController < ApplicationController

  def create
    @cheerup = Cheerup.find(params[:tweet][:cheerup_id].to_i)
    current_user.tweet(@cheerup)
    redirect_to @cheerup, notice: 'Tweet sent.' 
  end

 
end