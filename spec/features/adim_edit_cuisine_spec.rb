require 'rails_helper'

feature 'Admin update cuisine' do
  scenario 'successfully' do
    # cria os dados necessários
    cuisine = create(:cuisine)

    # simula a ação do usuário
    visit cuisine_path(cuisine)
    click_on 'Editar'
    fill_in 'Nome', with: 'Africana'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Africana')
  end
  scenario 'and fill name empty' do
    # cria os dados necessários
    cuisine = create(:cuisine)

    # simula a ação do usuário
    visit cuisine_path(cuisine)
    click_on 'Editar'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar o nome da cozinha')
  end
  scenario 'and must fill in name duplicate' do
    cuisine = create(:cuisine, name: 'Brasileira')

    visit cuisine_path(cuisine)
    click_on 'Editar'
    fill_in 'Nome', with: 'Brasileira'
    click_on 'Enviar'

    expect(page).to have_content('A cozinha já está cadastrada')
  end
end
