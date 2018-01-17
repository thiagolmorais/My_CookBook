class RecipesController < ApplicationController

before_action :authenticate_user!, only: [:new, :edit]

  def index
    @recipes = Recipe.all
    @cuisines = Cuisine.all
  end

  def show
    id = params[:id]
    @recipe = Recipe.find(id)
    @favorites = Favorite.all
  end

  def new
    @recipe = Recipe.new
    @cuisines = Cuisine.all
    @recipe_type = RecipeType.all
    @users = User.all
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to recipe_path(Recipe.last)
    else
      @recipe_type = RecipeType.all
      @cuisines = Cuisine.all
      flash.now[:error] = 'Você deve informar todos os dados da receita'
      render :new
    end
  end

  def edit
    id = params[:id]
    @recipe = Recipe.find(id)
    @cuisines = Cuisine.all
    @recipe_type = RecipeType.all
    if (current_user.id != @recipe.user_id)
      flash[:error] = 'Você não pode editar receitas enviadas por outros usuários.'
      redirect_to root_path
    end
  end

  def update
    id = params[:id]
    @recipe = Recipe.find(id)
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe.id)
    else
      @recipe_type = RecipeType.all
      @cuisines = Cuisine.all
      flash.now[:error] = 'Você deve informar todos os dados da receita'
      render :edit
    end
  end

  def search
    @term = params[:term]
    @recipes = Recipe.where(title: @term)
  end

  def destroy
    id = params[:id]
    @recipe = Recipe.find(id)
    if (current_user == @recipe.user)
      @recipe.destroy
      flash[:sucess] = 'Receita excluída com sucesso!'
      redirect_to root_path
    else
      flash[:error] = 'Você não pode excluir receitas enviadas por outros usuários.'
      redirect_to root_path
    end
  end

  private

  def recipe_params
    user_id = User
    params.require(:recipe).permit(:title, :recipe_type_id,
                                   :cuisine_id, :difficulty, :cook_time,
                                   :people_serve, :ingredients,:method, :user_id)
  end

end
