class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :update, :destroy, :favorite,
                                     :unfavorite, :share]
  before_action :all_recipe_type, only: [:new, :create, :edit, :update]
  before_action :all_cuisines, only: [:show, :new, :create, :edit, :update,
                                      :search, :favorites]
  before_action :require_login, only: [:edit]
  before_action :authenticate_user!, only: [:new, :favorites]

  def show
    @favorites = Favorite.all
    @recipe_types = RecipeType.all
  end

  def new
    @recipe = Recipe.new
    @recipe_types = RecipeType.all
    @users = User.all
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.featured = @featured
    if @recipe.save
      redirect_to recipe_path(Recipe.last)
    else
      @recipe_types = RecipeType.all
      flash.now[:error] = 'Você deve informar todos os dados da receita'
      render :new
    end
  end

  def edit
    @recipe_types = RecipeType.all
  end

  def update
    if @recipe.update(recipe_params)
      @recipe.update(featured: @featured)
      flash[:sucess] = 'Recita editada com sucesso'
      redirect_to recipe_path(@recipe.id)
    else
      @recipe_types = RecipeType.all
      flash.now[:error] = 'Você deve informar todos os dados da receita'
      render :edit
    end
  end

  def search
    @term = params[:term]
    @recipes = Recipe.where(title: @term)
    @recipe_types = RecipeType.all
  end

  def destroy
    return unless current_user == @recipe.user
    @recipe.destroy
    flash[:sucess] = 'Receita excluída com sucesso!'
    redirect_to root_path
  end

  def favorites
    @recipe_types = RecipeType.all
    unless current_user.favorite_recipes.any?
      flash.now[:notice] = 'Nenhuma receita favorita'
    end
    @recipes = current_user.favorite_recipes
  end

  def favorite
    @recipe.favorites.create(user: current_user)
    flash[:sucess] = 'Receita adicionada como Favorita'
    redirect_to recipe_path(@recipe)
  end

  def unfavorite
    Favorite.find_by(recipe: @recipe, user: current_user).destroy
    flash[:notice] = 'Receita excluida das Favoritas'
    redirect_to recipe_path @recipe
  end

  def share
    email = params[:email]
    message = params[:message]
    RecipesMailer.share(email, message, @recipe.id).deliver_now
    flash[:notice] = "Email envidado para #{email}"
    redirect_to @recipe
  end

  private

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def all_recipe_type
    @recipe_type = RecipeType.all
  end

  def all_cuisines
    @cuisines = Cuisine.all
  end

  def recipe_params
    @featured = featured
    params.require(:recipe).permit(:title, :recipe_type_id,
                                   :cuisine_id, :difficulty, :cook_time,
                                   :people_serve, :ingredients, :method, :image,
                                   :user_id)
  end

  def featured
    destaque = params[:featured]
      @featured = true if destaque == '1'
  end
end
