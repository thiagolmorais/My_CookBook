require 'rails_helper'

feature 'User update recipe' do
  scenario 'successfully' do
    # cria os dados necessários
    user = create(:user)
    create(:recipe, user: user)

    # simula a ação do usuário
    login_as(user)
    visit root_path
    within('div.last_recipes') do
      click_on 'Bolo de cenoura'
    end
    click_on 'Editar'
    fill_in 'Título', with: 'Bolo de cenoura'
    select 'Brasileira', from: 'Cozinha'
    select 'Sobremesa', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Médio'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Cenoura, farinha, ovo, oleo e chocolate'
    fill_in 'Como Preparar', with: 'Faça um bolo e uma cobertura de chocolate'

    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Bolo de cenoura')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Sobremesa')
    expect(page).to have_css('p', text: 'Brasileira')
    expect(page).to have_css('p', text: 'Médio')
    expect(page).to have_css('p', text: '45 minutos')
    expect(page).to have_css('p',
                             text: 'Cenoura, farinha, ovo, oleo e chocolate')
    expect(page).to have_css('p',
                             text: 'Faça um bolo e uma cobertura de chocolate')
    expect(page).to have_content('Recita editada com sucesso')
  end

  scenario 'and all fields must be filled' do
    # cria os dados necessários, nesse caso não vamos criar dados no banco
    user = create(:user)
    create(:recipe, user: user)

    # simula a ação do usuário
    login_as(user)
    visit root_path
    within('div.last_recipes') do
      click_on 'Bolo de cenoura'
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
    user = create(:user)
    create(:recipe, user: user)

    login_as(user)
    visit root_path
    within('div.last_recipes') do
      click_on 'Bolo de cenoura'
    end

    expect(page).to have_link('Editar')
  end

  scenario 'not edit by outher user' do
    user = create(:user, email: 'tf_lima@terra.com.br')
    recipe = create(:recipe, user: user)
    another_user = create(:user, email: 'joao@terra.com.br')

    login_as(another_user)
    visit root_path
    visit edit_recipe_path(recipe.id)

    expect(page).to have_current_path(root_path)
    expect(page).to have_content('Você não pode editar receitas enviadas por
       outros usuários.')
  end

  scenario 'not fill edit' do
    user = create(:user, email: 'tf_lima@terra.com.br')
    create(:recipe, user: user)
    another_user = create(:user, email: 'joao@terra.com.br')

    login_as(another_user)
    visit root_path
    within('div.last_recipes') do
      click_on 'Bolo de cenoura'
    end

    expect(page).not_to have_link('Editar')
  end

  scenario 'not edit by url without is logged' do
    recipe = create(:recipe)

    visit root_path
    visit edit_recipe_path(recipe.id)

    expect(page).to have_current_path(root_path)
    expect(page).to have_content('Acesso negado! Você precisa estar logado.')
  end
end
