class HomeController < ApplicationController

  def index
    @page = params.fetch(:page, 0).to_i
    @amount_of_pages = Cheerup.count

    @new_cheerups = Cheerup.offset(@page).order(:created_at).reverse_order
    @cheerup = @new_cheerups.first

    @best_cheerups = Cheerup.all
    @best_cheerups.sort!{ |a,b| a.rating <=> b.rating }.reverse!
    @best_cheerups = @best_cheerups[0..1]

    @best_cheerupers = User.all
    @best_cheerupers.sort!{ |a,b| a.rating <=> b.rating }.reverse!
    @best_cheerupers = @best_cheerupers[0..1]

  end

end