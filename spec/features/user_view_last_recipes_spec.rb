require 'rails_helper'

feature 'User view last 6 recipes' do

  scenario 'successfully' do
    user = User.create(username: 'Thiago', email: 'tf_lima@terra.com.br', password: '123456789')
    id = user.id

    cuisine = Cuisine.create(name: 'Arabe')
    cuisine_type = RecipeType.create(name: 'Sobremesa')

    recipe1 = Recipe.create(title: 'Bolodecenoura', recipe_type: cuisine_type,
                          cuisine: cuisine, difficulty: 'Médio',
                          cook_time: 50,
                          ingredients: 'Farinha, açucar, cenoura',
                          method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user_id: id)

    recipe2 = Recipe.create(title: 'Bolodelaranja', recipe_type: cuisine_type,
                          cuisine: cuisine, difficulty: 'Médio',
                          cook_time: 50,
                          ingredients: 'Farinha, açucar, cenoura',
                          method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user_id: id)

    recipe3 = Recipe.create(title: 'Bolodemanga', recipe_type: cuisine_type,
                          cuisine: cuisine, difficulty: 'Médio',
                          cook_time: 50,
                          ingredients: 'Farinha, açucar, cenoura',
                          method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user_id: id)

    recipe4 = Recipe.create(title: 'Bolodejaca', recipe_type: cuisine_type,
                          cuisine: cuisine, difficulty: 'Médio',
                          cook_time: 50,
                          ingredients: 'Farinha, açucar, cenoura',
                          method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user_id: id)

    recipe5 = Recipe.create(title: 'Bolodecereja', recipe_type: cuisine_type,
                          cuisine: cuisine, difficulty: 'Médio',
                          cook_time: 50,
                          ingredients: 'Farinha, açucar, cenoura',
                          method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user_id: id)

    recipe6 = Recipe.create(title: 'Bolodemilho', recipe_type: cuisine_type,
                          cuisine: cuisine, difficulty: 'Médio',
                          cook_time: 50,
                          ingredients: 'Farinha, açucar, cenoura',
                          method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user_id: id)

    recipe7 = Recipe.create(title: 'Bolodemorango', recipe_type: cuisine_type,
                          cuisine: cuisine, difficulty: 'Médio',
                          cook_time: 50,
                          ingredients: 'Farinha, açucar, cenoura',
                          method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user_id: id)

    visit root_path
    expect(page).to have_css('h1', text: 'Últimas Receitas')
    expect(page).to have_css('div.last_recipes', text: recipe7.title)
    expect(page).to have_css('div.last_recipes', text: recipe6.title)
    expect(page).to have_css('div.last_recipes', text: recipe5.title)
    expect(page).to have_css('div.last_recipes', text: recipe4.title)
    expect(page).to have_css('div.last_recipes', text: recipe3.title)
    expect(page).to have_css('div.last_recipes', text: recipe2.title)
    expect(page).not_to have_css('div.last_recipes', text: recipe1.title)
  end

end
