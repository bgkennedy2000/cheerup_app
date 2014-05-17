class CheerupsController < ApplicationController
  def new
    @cheerup = Cheerup.new
  end
end
