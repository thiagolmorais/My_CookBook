require 'rails_helper'

feature 'User visit other profile' do
  scenario 'successfully' do
    user = create(:user)
    recipe = create(:recipe, user: user)
    another_user = create(:user, username: 'Vanessa', email: 'user2@bol.com')

    login_as(another_user)
    visit root_path
    click_on recipe.title
    click_on recipe.user.username

    expect(page).to have_content(user.username)
    expect(page).to have_content(user.city)
    expect(page).to have_content(user.facebook)
    expect(page).to have_content(user.twitter)
  end

  scenario 'only recipes by profile' do
    cuisine = create(:cuisine)
    recipe_type = create(:recipe_type)
    user = create(:user)
    recipe = create(:recipe, title: 'Bolo de Cenoura', user: user, cuisine: cuisine, recipe_type: recipe_type)
    other_recipe = create(:recipe, title: 'Bolo de maça', user: user, cuisine: cuisine, recipe_type: recipe_type)
    another_user = create(:user, username: 'Vanessa', email: 'user2@bol.com')
    another_recipe = create(:recipe, title: 'Bolo de Chocolate',  user: another_user, cuisine: cuisine, recipe_type: recipe_type)

    login_as(another_user)
    visit root_path
    click_on recipe.title
    click_on recipe.user.username

    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('h1', text: other_recipe.title)
    expect(page).not_to have_css('h1', text: another_recipe.title)
  end

  scenario 'only recipes by profile' do
    user = create(:user)
    recipe = create(:recipe, user: user)
    other_user = create(:user, email: 'user2@bol.com')

    login_as(other_user)
    visit user_path(other_user)

    expect(page).to have_content(user.username)
    expect(page).to have_content(user.city)
    expect(page).to have_content(user.facebook)
    expect(page).to have_content(user.twitter)

    expect(page).not_to have_css('h1', text: recipe.title)
  end
end
