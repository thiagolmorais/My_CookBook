
require 'rails_helper'

feature 'Visitor view recipes by type' do
  scenario 'from home page' do
    # cria os dados necessários previamente
    recipe = create(:recipe)

    # simula a ação do usuário
    visit root_path
    click_on recipe.recipe_type.name

    # expectativas do usuário após a ação
    expect(page).to have_css('h1', text: recipe.recipe_type.name)
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
  end

  scenario 'and view only recipes from same type' do
    # cria os dados necessários previamente
    user = create(:user)
    id = user.id
    brazilian_cuisine = Cuisine.create(name: 'Brasileira')
    b_recipe_type = RecipeType.create(name: 'Sobremesa')
    b_recipe = Recipe.create(title: 'Bolo de cenoura',
                             recipe_type: b_recipe_type,
                             cuisine: brazilian_cuisine,
                             difficulty: 'Médio', cook_time: 60,
                             ingredients: 'Farinha, açucar, cenoura',
                             method: 'Cozinhe a cenoura', user_id: id)
    italian_cuisine = Cuisine.create(name: 'Italiana')
    i_recipe_type = RecipeType.create(name: 'Prato Principal')
    i_recipe = Recipe.create(title: 'Macarrão Carbonara',
                             recipe_type: i_recipe_type,
                             cuisine: italian_cuisine, difficulty: 'Difícil',
                             cook_time: 30, ingredients: 'Massa, ovo, bacon',
                             method: 'Frite o bacon e cozinhe a massa',
                             user_id: id)
    # simula a ação do usuário
    visit root_path
    click_on i_recipe_type.name

    # expectativas do usuário após a ação
    expect(page).to have_css('h1', text: i_recipe.title)
    expect(page).to have_css('li', text: i_recipe.recipe_type.name)
    expect(page).to have_css('li', text: i_recipe.cuisine.name)
    expect(page).to have_css('li', text: i_recipe.difficulty)
    expect(page).to have_css('li', text: "#{i_recipe.cook_time} minutos")
    expect(page).not_to have_css('h1', text: b_recipe.title)
    expect(page).not_to have_css('li', text: b_recipe.recipe_type.name)
    expect(page).not_to have_css('li', text: b_recipe.cuisine.name)
    expect(page).not_to have_css('li', text: b_recipe.difficulty)
    expect(page).not_to have_css('li', text: "#{b_recipe.cook_time} minutos")
  end

  scenario 'and type has no recipe' do
    # cria os dados necessários previamente
    user = create(:user)
    brazilian_cuisine = Cuisine.create(name: 'Brasileira')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: brazilian_cuisine, difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           method: 'Cozinhe a cenoura.',
                           user_id: user.id)
    main_dish_type = RecipeType.create(name: 'Prato Principal')
    # simula a ação do usuário
    visit root_path
    click_on main_dish_type.name

    # expectativas do usuário após a ação
    expect(page).not_to have_content(recipe.title)
    expect(page).to have_content('Nenhuma receita encontrada para este tipo de
       receitas')
  end
end
