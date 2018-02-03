require 'rails_helper'

feature 'User view last 6 recipes' do
  scenario 'successfully' do
    user = create(:user)
    cuisine = create(:cuisine)
    recipe_type = create(:recipe_type)
    recipe1 = create(:recipe, title: 'Bolo de cenoura', user: user,
                              cuisine: cuisine, recipe_type: recipe_type)
    recipe2 = create(:recipe, title: 'Bolo de laranja', user: user,
                              cuisine: cuisine, recipe_type: recipe_type)
    recipe3 = create(:recipe, title: 'Bolo de chocolate', user: user,
                              cuisine: cuisine, recipe_type: recipe_type)
    recipe4 = create(:recipe, title: 'Bolo formigueiro', user: user,
                              cuisine: cuisine, recipe_type: recipe_type)
    recipe5 = create(:recipe, title: 'Bolo de maça com canela', user: user,
                              cuisine: cuisine, recipe_type: recipe_type)
    recipe6 = create(:recipe, title: 'Bolo de banana', user: user,
                              cuisine: cuisine, recipe_type: recipe_type)
    recipe7 = create(:recipe, title: 'Bolo de milho', user: user,
                              cuisine: cuisine, recipe_type: recipe_type)

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
