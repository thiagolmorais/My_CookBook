class RecipesController < ApplicationController

  def show
    id = params[:id]
    @recipe = Recipe.find(id)
  end

  def new
    @recipe = Recipe.new
  end

  def create
    title = params[:recipe][:title]
    recipe_type = params[:recipe][:recipe_type]
    cuisine = params[:recipe][:cuisine]
    difficulty = params[:recipe][:difficulty]
    cook_time = params[:recipe][:cook_time]
    people_serve = params[:recipe][:people_serve]
    ingredients = params[:recipe][:ingredients]
    method = params[:recipe][:method]
    r = Recipe.new(title: title, recipe_type: recipe_type,
       cuisine: cuisine, difficulty: difficulty, cook_time: cook_time,
       people_serve: people_serve, ingredients: ingredients, method: method)
    r.save

    redirect_to recipe_path(Recipe.last)
  end

end
