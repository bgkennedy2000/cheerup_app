class ApplicationController < ActionController::Base
  protect_from_forgery

  def index
    if current_user
      redirect_to home_path
    else
      render 'index'
    end
  end

end
