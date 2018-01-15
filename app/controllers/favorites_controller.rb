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

  def destroy
    @favorites = Favorite.all
    id = params[:id]
    @favorite = Favorite.find(id)
    @recipe = @favorite.recipe_id
    if (current_user.id == @favorite.user_id)
      @favorite.destroy
      flash[:sucess] = 'Receita excluida das Favoritas'
      redirect_to recipe_path(@recipe)
    end
  end

end
