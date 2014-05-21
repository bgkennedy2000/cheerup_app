class HomeController < ApplicationController

  def index
    @page = params.fetch(:page, 1).to_i
    per_page = 1
    @amount_of_pages = (Cheerup.count.to_f / per_page).ceil

    @new_cheerups = Cheerup.offset(@page*per_page).limit(per_page).order(:created_at)
    @new_cheerups.reverse!
    @cheerup = @new_cheerups.last

    @best_cheerups = Cheerup.all
    @best_cheerups.sort!{ |a,b| a.rating <=> b.rating }.reverse!
    @best_cheerups = @best_cheerups[0..1]

    @best_cheerupers = User.all
    @best_cheerupers.sort!{ |a,b| a.rating <=> b.rating }.reverse!
    @best_cheerupers = @best_cheerupers[0..1]

  end

end