class RecipeTypesController < ApplicationController
  def index
    @recipe_types = RecipeType.all
  end

  def show
    id = params[:id]
    @recipe_type = RecipeType.find(id)
    @recipe_types = RecipeType.all
    @recipes = Recipe.all
    @cuisines = Cuisine.all
  end

  def new
    @recipe_type = RecipeType.new
  end

  def create
    @recipe_type = RecipeType.new(recipe_type_params)
    if @recipe_type.save
      redirect_to recipe_type_path(RecipeType.last)
    else
      flash.now[:error] = 'O tipo de receita já está cadastrado' if @recipe_type.name?
      flash.now[:error] = 'Você deve informar o nome do tipo de receita' unless @recipe_type.name?
      render :new
    end
  end

    def edit
      @recipe_type = RecipeType.find(params[:id])
    end

    def update
      @recipe_type = RecipeType.new(recipe_type_params)
      if @recipe_type.update(recipe_type_params)
        redirect_to recipe_type_path(RecipeType.last)
      else
        flash.now[:error] = 'O tipo de receita já está cadastrado' if @recipe_type.name?
        flash.now[:error] = 'Você deve informar o nome do tipo de receita' unless @recipe_type.name?
        render :edit
      end
    end

  private

  def recipe_type_params
    params.require(:recipe_type).permit(:name)
  end
end
