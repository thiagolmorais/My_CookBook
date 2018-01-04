class CuisinesController < ApplicationController

  def show
    id = params[:id]
    @cuisine = Cuisine.find(id)
  end

  def new
    @cuisine = Cuisine.new
  end

  def create
    cuisine = params[:cuisine][:name]
    c = Cuisine.new(name: cuisine)
    c.save

    redirect_to cuisine_path(Cuisine.last)
  end

end
