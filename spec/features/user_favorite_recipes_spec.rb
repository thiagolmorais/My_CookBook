require 'rails_helper'

feature 'User select favorite recipes' do

  scenario 'Sucess' do
    user = User.create(username: 'Thiago', email: 'tf_lima@terra.com.br', password: '123456789')
    id = user.id

    cuisine = Cuisine.create(name: 'Arabe')
    cuisine_type = RecipeType.create(name: 'Sobremesa')

    recipe = Recipe.create(title: 'Bolodecenoura', recipe_type: cuisine_type,
                          cuisine: cuisine, difficulty: 'Médio',
                          cook_time: 50,
                          ingredients: 'Farinha, açucar, cenoura',
                          method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user_id: id)

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password

    within('div.actions') do
      click_on 'Entrar'
    end
    within('div.last_recipes') do
      click_on 'Bolodecenoura'
    end
    click_on 'Salvar como Favorita'

    expect(page).to have_css('p', text: 'Receita adicionada como Favorita')
  end


  scenario 'Sucess' do
    user = User.create(username: 'Thiago', email: 'tf_lima@terra.com.br', password: '123456789')
    id = user.id
    another_user = User.create(username: 'Vanessa', email: 'Vanessa@terra.com.br', password: '123456789')
    another_id = another_user.id

    cuisine = Cuisine.create(name: 'Arabe')
    cuisine_type = RecipeType.create(name: 'Sobremesa')

    recipe = Recipe.create(title: 'Bolodecenoura', recipe_type: cuisine_type,
                          cuisine: cuisine, difficulty: 'Médio',
                          cook_time: 50,
                          ingredients: 'Farinha, açucar, cenoura',
                          method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user_id: id)

    another_recipe = Recipe.create(title: 'Bolodeabacate', recipe_type: cuisine_type,
                          cuisine: cuisine, difficulty: 'Médio',
                          cook_time: 50,
                          ingredients: 'Farinha, açucar, cenoura',
                          method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user_id: another_id)


    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password

    within('div.actions') do
      click_on 'Entrar'
    end
    within('div.last_recipes') do
      click_on 'Bolodecenoura'
    end
    click_on 'Salvar como Favorita'
    visit favorites_path

    expect(page).to have_css('h1', text: 'Minhas Receitas Favoritas')
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).not_to have_css('h1', text: another_recipe.title)
  end




end
