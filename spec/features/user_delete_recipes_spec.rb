require 'rails_helper'

feature 'user delete recipes' do
  scenario 'successfully' do
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
      click_on recipe.title
    end
    click_on 'Excluir Receita'

    expect(page).to have_content 'Receita excluída com sucesso!'
    expect(page).not_to have_content(recipe.title)
  end

end
