require 'rails_helper'

feature 'User select favorite recipes' do

  scenario 'Sucess' do
    user = create(:user)
    recipe = create(:recipe, user: user)

    login_as(user)
    visit root_path
    within('div.last_recipes') do
      click_on 'Bolo de cenoura'
    end
    click_on 'Salvar como Favorita'

    expect(page).to have_css('p', text: 'Receita adicionada como Favorita')
  end


  scenario 'Sucess' do
    user = create(:user, email: 'tf_lima@terra.com.br')
    another_user = create(:user, email: 'joao@terra.com.br')
    recipe = create(:recipe, title: 'Bolo de cenoura', user: user)
    another_recipe = create(:recipe, title: 'Bolo de chocolate', user: another_user)

    login_as(user)
    visit root_path
    within('div.last_recipes') do
      click_on 'Bolo de cenoura'
    end
    click_on 'Salvar como Favorita'
    visit favorites_path

    expect(page).to have_css('h1', text: 'Minhas Receitas Favoritas')
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).not_to have_css('h1', text: another_recipe.title)
  end

  scenario 'delete' do
    user = create(:user)
    recipe = create(:recipe, user: user)

    login_as(user)
    visit root_path
    within('div.last_recipes') do
      click_on 'Bolo de cenoura'
    end
    click_on 'Salvar como Favorita'
    visit favorites_path
    click_on 'Bolo de cenoura'
    click_on 'Excluir das Favoritas'

    expect(page).to have_css('p', text: 'Receita excluida das Favoritas')
  end



end
