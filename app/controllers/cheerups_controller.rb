class CheerupsController < ApplicationController
  
  def index
    @cheerups = Cheerup.all
  end

  def new
    @cheerup = Cheerup.new
  end


  def create
    @cheerup = Cheerup.new(params[:cheerup])
    @cheerup.user = current_user

    valid_for_draft = @cheerup.make_cheerup

    respond_to do |format|
      if valid_for_draft && @cheerup.message
        format.html { redirect_to @cheerup, notice: 'Cheerup was successfully created.' }
        format.json { render json: @cheerup, status: :created, location: @cheerup }
      elsif valid_for_draft
        format.html { render action: "edit" }
        format.json { render json: @cheerup, status: :image_loaded }
      else
        format.html { render action: "new" }
        format.json { render json: @cheerup.errors, status: :unprocessable_entity }
      end
    end
  end



  def show
    @cheerup = Cheerup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cheerup }
    end
  end

  
 
  def edit
    @cheerup = Cheerup.find(params[:id])
  end

 
  def update
    @cheerup = Cheerup.find(params[:id])

    respond_to do |format|
      if @cheerup.update_cheerup_attributes(params[:cheerup])
        format.html { redirect_to @cheerup, notice: 'Cheerup was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cheerup.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def destroy
    @cheerup = Cheerup.find(params[:id])
    @cheerup.destroy

    respond_to do |format|
      format.html { redirect_to current_user }
      format.json { head :no_content }
    end
  end










end
