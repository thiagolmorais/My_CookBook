class RecipeController < ApplicationController

  def show
    id = params[:id]
    @recipes = Recipe.find(id)
  end

end
