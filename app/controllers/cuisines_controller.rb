class CuisinesController < ApplicationController

  def index
    @cuisines = Cuisine.all
  end


  def show
    id = params[:id]
    @cuisine = Cuisine.find(id)
    @recipes = Recipe.all
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
