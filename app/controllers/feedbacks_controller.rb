class FeedbacksController < ApplicationController

  def create

    @user = current_user
    @cheerup = Cheerup.find(params[:cheerup])
    @feedback = Feedback.build(cheerup_id: @cheerup.id, user_id: @user.id)

    if @feedback.save
      redirect_to @cheerup, notice: 'Feedback was successfully created.' 
    else
      redirect_to @cheerup, notice: 'Feedback not successfully created.' 
    end

  end

end