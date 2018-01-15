class FavoritesController < ApplicationController

  def index
    @recipes = Recipe.all
    @favorites = Favorite.all
  end

  def create
    recipe = params[:recipe_id]
    user = params[:user_id]
    @favorite = Favorite.create(recipe_id: recipe, user_id: user, control: "#{recipe}#{user}" )
    flash[:sucess] = 'Receita adicionada como Favorita'
    redirect_to recipe_path(recipe)
  end

end
