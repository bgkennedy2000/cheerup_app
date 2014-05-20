class FeedbacksController < ApplicationController

  def create

    @user = current_user
    @cheerup = Cheerup.find(params[:cheerup_id])
    @feedback = Feedback.first_or_initialize(cheerup_id: @cheerup.id, user_id: @user.id)
      @feedback.kind = params[:kind]

    if @feedback.save
      redirect_to @cheerup, notice: 'Feedback was successfully created.' 
    else
      redirect_to @cheerup, notice: 'Feedback not successfully created.' 
    end

  end


end