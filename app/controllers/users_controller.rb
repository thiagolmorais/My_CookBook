class UsersController < ApplicationController
  def show
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
    @user = User.find(params[:id])
  end
end
