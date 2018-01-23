require 'rails_helper'

feature 'User select favorite recipes' do
  scenario 'successfully' do
    user = create(:user)
    create(:recipe, user: user)

    login_as(user)
    visit root_path
    within('div.last_recipes') do
      click_on 'Bolo de cenoura'
    end
    click_on 'Salvar como Favorita'

    expect(page).to have_css('p', text: 'Receita adicionada como Favorita')
    expect(page).to have_link('Excluir das Favoritas')
    expect(page).not_to have_link('Salvar como Favorita')
  end

  scenario 'visit minhas receitas favorias' do
    user = create(:user, email: 'tf_lima@terra.com.br')
    another_user = create(:user, email: 'joao@terra.com.br')
    recipe = create(:recipe, title: 'Bolo de cenoura', user: user)
    another_recipe = create(:recipe, title: 'Bolo de chocolate',
                                     user: another_user)

    login_as(user)
    visit root_path
    within('div.last_recipes') do
      click_on 'Bolo de cenoura'
    end
    click_on 'Salvar como Favorita'
    visit favorites_recipes_path

    expect(page).to have_css('h1', text: 'Minhas Receitas Favoritas')
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).not_to have_css('h1', text: another_recipe.title)
  end

  scenario 'receitas favorias is nil' do
    user = create(:user, email: 'tf_lima@terra.com.br')
    recipe = create(:recipe, title: 'Bolo de cenoura', user: user)

    login_as(user)
    visit favorites_recipes_path

    expect(page).to have_content('Nenhuma receita favorita')
    expect(page).not_to have_css('h1', text: recipe.title)
  end

  scenario 'delete favorite' do
    user = create(:user)
    create(:recipe, user: user)

    login_as(user)
    visit root_path
    within('div.last_recipes') do
      click_on 'Bolo de cenoura'
    end
    click_on 'Salvar como Favorita'
    visit favorites_recipes_path
    click_on 'Bolo de cenoura'
    click_on 'Excluir das Favoritas'

    expect(page).to have_css('p', text: 'Receita excluida das Favoritas')
    expect(page).not_to have_link('Excluir das Favoritas')
    expect(page).to have_link('Salvar como Favorita')
  end

  scenario 'delete recipe favorited' do
    user = create(:user)
    recipe = create(:recipe, title: 'Bolo de cenoura', user: user)
    another_recipe = create(:recipe, title: 'Bolo de chocolate', user: user)
    Favorite.create(user: user, recipe: recipe)
    Favorite.create(user: user, recipe: another_recipe)

    login_as(user)
    visit root_path
    within('div.last_recipes') do
      click_on recipe.title
    end
    click_on 'Excluir Receita'
    visit favorites_recipes_path

    expect(page).to have_link(another_recipe.title)
    expect(page).not_to have_link(recipe.title)
  end
end
