class FeedbacksController < ApplicationController

  def create

    @user = current_user
    @cheerup = Cheerup.find(params[:cheerup_id])
    @feedback = Feedback.new(cheerup_id: @cheerup.id, user_id: @user.id,
      kind: params[:kind])

    if @feedback.save
      redirect_to home_path, notice: 'Feedback was successfully created.' 
    else
      redirect_to home_path, notice: 'Feedback not successfully created. '+@feedback.errors.full_messages.join(". ")+"."
    end

  end


end