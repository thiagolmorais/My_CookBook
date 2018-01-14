require 'rails_helper'

feature 'User update recipe' do
  scenario 'successfully' do
    #cria os dados necessários
    user = User.create(username: 'Thiago', email: 'tf_lima@terra.com.br', password: '123456789')
    id = user.id
    arabian_cuisine = Cuisine.create(name: 'Arabe')
    brazilian_cuisine = Cuisine.create(name: 'Brasileira')

    appetizer_type = RecipeType.create(name: 'Entrada')
    main_type = RecipeType.create(name: 'Prato Principal')
    dessert_type = RecipeType.create(name: 'Sobremesa')

    recipe = Recipe.create(title: 'Bolodecenoura', recipe_type: main_type,
                          cuisine: arabian_cuisine, difficulty: 'Médio',
                          cook_time: 50,
                          ingredients: 'Farinha, açucar, cenoura',
                          method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user_id: id)

    # simula a ação do usuário
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
    click_on 'Editar'

    fill_in 'Título', with: 'Bolo de cenoura'
    select 'Brasileira', from: 'Cozinha'
    select 'Sobremesa', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Médio'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Cenoura, farinha, ovo, oleo de soja e chocolate'
    fill_in 'Como Preparar', with: 'Faça um bolo e uma cobertura de chocolate'

    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Bolo de cenoura')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Sobremesa')
    expect(page).to have_css('p', text: 'Brasileira')
    expect(page).to have_css('p', text: 'Médio')
    expect(page).to have_css('p', text: '45 minutos')
    expect(page).to have_css('p', text:  'Cenoura, farinha, ovo, oleo de soja e chocolate')
    expect(page).to have_css('p', text: 'Faça um bolo e uma cobertura de chocolate')
  end

  scenario 'and all fields must be filled' do
    #cria os dados necessários, nesse caso não vamos criar dados no banco
    user = User.create(username: 'Thiago', email: 'tf_lima@terra.com.br', password: '123456789')
    id = user.id
    arabian_cuisine = Cuisine.create(name: 'Arabe')
    brazilian_cuisine = Cuisine.create(name: 'Brasileira')

    appetizer_type = RecipeType.create(name: 'Entrada')
    main_type = RecipeType.create(name: 'Prato Principal')
    dessert_type = RecipeType.create(name: 'Sobremesa')

    recipe = Recipe.create(title: 'Bolodecenoura', recipe_type: main_type,
                          cuisine: arabian_cuisine, difficulty: 'Médio',
                          cook_time: 50,
                          ingredients: 'Farinha, açucar, cenoura',
                          method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user_id: id)

    # simula a ação do usuário
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
    click_on 'Editar'

    fill_in 'Título', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''

    click_on 'Enviar'

    expect(page).to have_content('Você deve informar todos os dados da receita')
  end

  scenario 'edit only user user_signed_in' do
    user = User.create(username: 'Thiago', email: 'tf_lima@terra.com.br', password: '123456789')
    id = user.id
    cuisine = Cuisine.create(name: 'Arabe')
    type = RecipeType.create(name: 'Prato Principal')
    recipe = Recipe.create(title: 'Bolodecenoura', recipe_type: type,
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

    expect(page).to have_link('Editar')
  end

  scenario 'not edit by outher user' do

    user = User.create(username: 'Thiago', email: 'tf_lima@terra.com.br', password: '123456789')
    id = user.id
    cuisine = Cuisine.create(name: 'Arabe')
    type = RecipeType.create(name: 'Prato Principal')

    recipe = Recipe.create(title: 'Bolodecenoura', recipe_type: type,
                          cuisine: cuisine, difficulty: 'Médio',
                          cook_time: 50,
                          ingredients: 'Farinha, açucar, cenoura',
                          method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user_id: id)

    another_user = User.create(username: 'João', email: 'joao@terra.com.br', password: '123456')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: another_user.email
    fill_in 'Senha', with: another_user.password

    within('div.actions') do
      click_on 'Entrar'
    end
    visit edit_recipe_path(recipe.id)

    expect(page).to have_current_path(root_path)
    expect(page).to have_content('Você não pode editar receitas enviadas por outros usuários.')
  end

  scenario 'not fill edit' do

    user = User.create(username: 'Thiago', email: 'tf_lima@terra.com.br', password: '123456789')
    id = user.id
    cuisine = Cuisine.create(name: 'Arabe')
    type = RecipeType.create(name: 'Prato Principal')

    recipe = Recipe.create(title: 'Bolodecenoura', recipe_type: type,
                          cuisine: cuisine, difficulty: 'Médio',
                          cook_time: 50,
                          ingredients: 'Farinha, açucar, cenoura',
                          method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user_id: id)

    another_user = User.create(username: 'João', email: 'joao@terra.com.br', password: '123456')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: another_user.email
    fill_in 'Senha', with: another_user.password

    within('div.actions') do
      click_on 'Entrar'
    end
    within('div.last_recipes') do
      click_on 'Bolodecenoura'
    end
    
    expect(page).not_to have_link('Editar')
  end

end
