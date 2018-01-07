class RecipeTypesController < ApplicationController

  def index
    @recipe_types = RecipeType.all
  end


  def show
    id = params[:id]
    @recipe_type = RecipeType.find(id)
    @recipes = Recipe.all
  end

  def new
    @recipe_type = RecipeType.new
  end

  def create
    recipe_type_params = params.require(:recipe_type).permit(:name)
    @recipe_type = RecipeType.new(recipe_type_params)

    if (@recipe_type.name == '')
      redirect_to new_recipe_type_path, alert: 'Você deve informar o tipo da receita'
    else
      @recipe_type.save
      redirect_to recipe_type_path(RecipeType.last)
    end

  end

end
