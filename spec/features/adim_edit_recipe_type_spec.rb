require 'rails_helper'

feature 'Admin update recipe_type' do
  scenario 'successfully' do
    # cria os dados necessários
    recipe_type = create(:recipe_type)

    # simula a ação do usuário
    visit recipe_type_path(recipe_type)
    click_on 'Editar'
    fill_in 'Nome', with: 'Prato Principal'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Prato Principal')
  end
  scenario 'and fill name empty' do
    # cria os dados necessários
    recipe_type = create(:recipe_type)

    # simula a ação do usuário
    visit recipe_type_path(recipe_type)
    click_on 'Editar'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar o nome do tipo de receita')
  end
  scenario 'and must fill in name duplicate' do
    recipe_type = create(:recipe_type, name: 'Sobremesa')

    visit recipe_type_path(recipe_type)
    click_on 'Editar'
    fill_in 'Nome', with: 'Sobremesa'
    click_on 'Enviar'

    expect(page).to have_content('O tipo de receita já está cadastrado')
  end
end
