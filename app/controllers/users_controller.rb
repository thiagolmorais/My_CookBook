class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @recipes = Recipe.all
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
    @user = User.find(params[:id])
  end
end
