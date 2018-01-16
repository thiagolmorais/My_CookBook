require 'rails_helper'

feature 'user delete recipes' do
  scenario 'successfully' do

    user = create(:user)
    recipe = create(:recipe, user: user)

    login_as(user, :scope => :user)
    visit root_path
    within('div.last_recipes') do
      click_on recipe.title
    end
    click_on 'Excluir Receita'

    expect(page).to have_content 'Receita excluída com sucesso!'
    expect(page).not_to have_content(recipe.title)
  end

end
