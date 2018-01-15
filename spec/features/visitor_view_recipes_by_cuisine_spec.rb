require 'rails_helper'

feature 'Visitor view recipes by cuisine' do

  scenario 'from home page' do
    # cria os dados necessários previamente

    recipe = create(:recipe)

    # simula a ação do usuário
    visit root_path
    click_on recipe.cuisine.name

    # expectativas do usuário após a ação
    expect(page).to have_css('h1', text: recipe.cuisine.name)
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
  end

  scenario 'and view only cuisine recipes' do
    # cria os dados necessários previamente
    user = create(:user)
    brazilian_recipe_type = create(:recipe_type, name: 'Sobremesa')
    italian_recipe_type = create(:recipe_type, name: 'Prato Principal')
    brazilian_cuisine = create(:cuisine, name: 'Brasileira')
    italian_cuisine = create(:cuisine, name: 'Italiana')
    brazilian_recipe = create(:recipe, title: 'Bolo de cenoura', recipe_type: brazilian_recipe_type, cuisine: brazilian_cuisine, difficulty: 'Médio', cook_time: 60, user: user)
    italian_recipe = create(:recipe, title: 'Macarrão Carbonara', recipe_type: italian_recipe_type, cuisine: italian_cuisine, difficulty: 'Difícil', cook_time: 30, user: user)

    # simula a ação do usuário
    visit root_path
    click_on italian_cuisine.name

    # expectativas do usuário após a ação
    expect(page).to have_css('h1', text: italian_recipe.title)
    expect(page).to have_css('li', text: italian_recipe.recipe_type.name)
    expect(page).to have_css('li', text: italian_recipe.cuisine.name)
    expect(page).to have_css('li', text: italian_recipe.difficulty)
    expect(page).to have_css('li', text: "#{italian_recipe.cook_time} minutos")
  end

  scenario 'and cuisine has no recipe' do
    # cria os dados necessários previamente

    italian_cuisine = create(:cuisine, name:'Italiana')
    brazilian_cuisine = create(:cuisine, name:'Brasileira')
    brazilian_recipe = create(:recipe, cuisine: brazilian_cuisine)

    # simula a ação do usuário
    visit root_path
    click_on italian_cuisine.name

    # expectativas do usuário após a ação
    expect(page).not_to have_content(brazilian_recipe.title)
    expect(page).to have_content('Nenhuma receita encontrada para este tipo de cozinha')
  end
end
