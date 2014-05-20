class HomeController < ApplicationController

  def index
    @new_cheerups = Cheerup.all
    @best_cheerups = Cheerup.find(:all, :limit => 2).reverse
    @best_cheerupers = User.all
  end

end