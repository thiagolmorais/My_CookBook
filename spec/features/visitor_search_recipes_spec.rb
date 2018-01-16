require 'rails_helper'

feature 'Visitor search for recipes' do
  scenario 'from home page' do
    # cria os dados necessários previamente

    user = create(:user)
    cuisine = create(:cuisine)
    recipe_type = create(:recipe_type)
    recipe = create(:recipe, title: 'Bolo de cenoura', cuisine: cuisine, recipe_type: recipe_type, user: user)
    another_recipe = create(:recipe, title: 'Salada de cenoura', cuisine: cuisine, recipe_type: recipe_type, user: user)

    # simula a ação do usuário
    visit root_path
    fill_in 'Busca', with: 'Bolo de cenoura'
    click_on 'Buscar'

    # expectativas do usuário após a ação
    expect(page).to have_css('h1', text: 'Resultado da busca por: Bolo de cenoura')
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
    expect(page).not_to have_css('h1', text: another_recipe.title)
  end

  scenario 'and navigate to recipe details' do
    # cria os dados necessários previamente
    recipe = create(:recipe)

    # simula a ação do usuário
    visit root_path
    fill_in 'Busca', with: 'Bolo de cenoura'
    click_on 'Buscar'
    click_on 'Bolo de cenoura'

    # expectativas do usuário após a ação
    expect(current_path).to eq(recipe_path(recipe))
  end
end
