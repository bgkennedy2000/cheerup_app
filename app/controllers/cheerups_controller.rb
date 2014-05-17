class CheerupsController < ApplicationController
  


  def new
    @cheerup = Cheerup.new
  end




def create
    @cheerup = Cheerup.new(params[:cheerup])
    @cheerup.user = current_user


    respond_to do |format|
      if @cheerup.save
        format.html { redirect_to @cheerup, notice: 'Cheerup was successfully created.' }
        format.json { render json: @cheerup, status: :created, location: @cheerup }
      else
        format.html { render action: "new" }
        format.json { render json: @cheerup.errors, status: :unprocessable_entity }
      end
    end
  end














end
