class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
    @cuisines = Cuisine.all
  end

  def show
    id = params[:id]
    @recipe = Recipe.find(id)
  end

  def new
    @recipe = Recipe.new
    @cuisines = Cuisine.all
  end

  def create
    recipe_params = params.require(:recipe).permit(:title, :recipe_type,
       :cuisine_id, :difficulty, :cook_time, :people_serve, :ingredients,:method)
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      redirect_to recipe_path(Recipe.last)
    else
      redirect_to new_recipe_path, alert: 'Você deve informar todos os dados da receita'
    end

  end

end
