require 'rails_helper'

feature 'Visitor visit homepage' do
  scenario 'successfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'CookBook')
    expect(page)
      .to have_css('p', text: 'Bem-vindo ao maior livro de receitas online')
  end

  scenario 'and view recipe' do
    # cria os dados necessários
    recipe = create(:recipe)

    # simula a ação do usuário
    visit root_path

    # expectativas do usuário após a ação
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
  end

  scenario 'and view recipes list' do
    # cria os dados necessários
    user = create(:user)
    cuisine = create(:cuisine)
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = create(:recipe, title: 'Bolo de cenoura', recipe_type: recipe_type,
                             difficulty: 'Médio', cook_time: 60, user: user,
                             cuisine: cuisine)
    another_recipe_type = create(:recipe_type, name: 'Prato Principal')
    another_recipe = create(:recipe, title: 'Feijoada',
                                     recipe_type: another_recipe_type,
                                     difficulty: 'Difícil', cook_time: 90,
                                     user: user, cuisine: cuisine)

    # simula a ação do usuário
    visit root_path

    # expectativas do usuário após a ação
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
    expect(page).to have_css('h1', text: another_recipe.title)
    expect(page).to have_css('li', text: another_recipe.recipe_type.name)
    expect(page).to have_css('li', text: another_recipe.cuisine.name)
    expect(page).to have_css('li', text: another_recipe.difficulty)
    expect(page).to have_css('li', text: "#{another_recipe.cook_time} minutos")
  end

  scenario 'and see 3 recipes more favorited' do
    user1 = create(:user, email: 'user1@bol.com')
    user2 = create(:user, email: 'user2@bol.com')
    user3 = create(:user, email: 'user3@bol.com')
    user4 = create(:user, email: 'user4@bol.com')
    user5 = create(:user, email: 'user5@bol.com')
    user6 = create(:user, email: 'user6@bol.com')
    user7 = create(:user, email: 'user7@bol.com')
    user8 = create(:user, email: 'user8@bol.com')
    user9 = create(:user, email: 'user9@bol.com')
    user10 = create(:user, email: 'user10@bol.com')
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    recipe1 = create(:recipe, title: 'Bolo1', user: user1, cuisine: cuisine,
                              recipe_type:recipe_type)
    recipe2 = create(:recipe, title: 'Bolo2', user: user1, cuisine: cuisine,
                              recipe_type:recipe_type)
    recipe3 = create(:recipe, title: 'Bolo3', user: user1, cuisine: cuisine,
                              recipe_type:recipe_type)
    recipe4 = create(:recipe, title: 'Bolo4', user: user1, cuisine: cuisine,
                              recipe_type:recipe_type)
    recipe5 = create(:recipe, title: 'Bolo5', user: user1, cuisine: cuisine,
                              recipe_type:recipe_type)
    recipe6 = create(:recipe, title: 'Bolo6', user: user1, cuisine: cuisine,
                              recipe_type:recipe_type)
    Favorite.create(user: user1, recipe: recipe3)
    Favorite.create(user: user2, recipe: recipe3)
    Favorite.create(user: user3, recipe: recipe3)
    Favorite.create(user: user4, recipe: recipe3)
    Favorite.create(user: user5, recipe: recipe5)
    Favorite.create(user: user6, recipe: recipe5)
    Favorite.create(user: user7, recipe: recipe5)
    Favorite.create(user: user8, recipe: recipe2)
    Favorite.create(user: user9, recipe: recipe2)
    Favorite.create(user: user10, recipe: recipe4)

    visit root_path

    expect(page).to have_css('div.more_favorited_recipes',
                             text: recipe3.title)
    expect(page).to have_css('div.more_favorited_recipes',
                             text: recipe5.title)
    expect(page).to have_css('div.more_favorited_recipes',
                             text: recipe2.title)
    expect(page).not_to have_css('div.more_favorited_recipes',
                                 text: recipe1.title)
    expect(page).not_to have_css('div.more_favorited_recipes',
                                 text: recipe4.title)
    expect(page).not_to have_css('div.more_favorited_recipes',
                                 text: recipe6.title)
  end
end
