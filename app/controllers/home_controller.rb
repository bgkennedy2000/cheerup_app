class HomeController < ApplicationController

  def index
    @new_cheerups = Cheerup.order('id').limit(9).reverse

    @featured_cheerup = @new_cheerups.first

    @best_cheerups = Cheerup.all
    @best_cheerups.sort!{ |a,b| a.rating <=> b.rating }.reverse!
    @best_cheerups = @best_cheerups[0..1]

    @best_cheerupers = User.all
    @best_cheerupers.sort!{ |a,b| a.rating <=> b.rating }.reverse!
    @best_cheerupers = @best_cheerupers[0..1]
  end

end