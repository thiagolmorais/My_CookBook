class HomeController < ApplicationController

  def index
    @recipes = Recipe.all
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all
    @last_recipes = @recipes.last(6)
    #@more_favorited = Favorite.group(:recipe_id).count
    @fav = Favorite.group(:recipe_id).count.sort_by{|k, v| v}.reverse.first(3).to_h
    @more_favorited = []
    @fav.each_entry do |k,v|
      @more_favorited << Recipe.find(k)
    end
  end

end
