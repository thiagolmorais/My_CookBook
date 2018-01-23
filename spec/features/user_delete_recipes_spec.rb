require 'rails_helper'

feature 'user delete recipes' do
  scenario 'successfully' do
    user = create(:user)
    recipe = create(:recipe, user: user)

    login_as(user)
    visit root_path
    within('div.last_recipes') do
      click_on recipe.title
    end
    click_on 'Excluir Receita'

    expect(page).to have_content 'Receita excluída com sucesso!'
    expect(page).not_to have_content(recipe.title)
  end

  scenario 'but not logged' do
    user = create(:user)
    recipe = create(:recipe, user: user)

    visit root_path
    within('div.last_recipes') do
      click_on recipe.title
    end

    expect(page).not_to have_link('Excluir Receita')
  end

  scenario 'but is not author this recipe' do
    user = create(:user, email: 'user@terra.com.br')
    another_user = create(:user, email: 'another_user@terra.com.br')
    recipe = create(:recipe, user: user)

    login_as(another_user)
    visit root_path
    within('div.last_recipes') do
      click_on recipe.title
    end

    expect(page).not_to have_link('Excluir Receita')
  end
end
