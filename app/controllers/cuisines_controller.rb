class CuisinesController < ApplicationController
  def index
    @cuisines = Cuisine.all
  end

  def show
    id = params[:id]
    @cuisine = Cuisine.find(id)
    @cuisines = Cuisine.all
    @recipes = Recipe.all
    @recipe_types = RecipeType.all
  end

  def new
    @cuisine = Cuisine.new
  end

  def create
    @cuisine = Cuisine.new(cuisine_params)
    if @cuisine.save
      redirect_to cuisine_path(Cuisine.last)
    else
      flash.now[:error] = 'A cozinha já está cadastrada' if @cuisine.name?
      flash.now[:error] = 'Você deve informar o nome da cozinha' unless @cuisine.name?
      render :new
    end
  end

  private

  def cuisine_params
    params.require(:cuisine).permit(:name)
  end
end
