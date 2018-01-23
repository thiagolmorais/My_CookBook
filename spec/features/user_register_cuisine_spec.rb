require 'rails_helper'

feature 'User register cuisine' do
  scenario 'successfully' do

    visit new_cuisine_path
    fill_in 'Nome', with: 'Brasileira'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Brasileira')
    expect(page).to have_content('Nenhuma receita encontrada para este tipo de cozinha')
  end

  scenario 'and must fill in name' do
    visit new_cuisine_path
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar o nome da cozinha')
  end

  scenario 'show all cuisines' do
    cuisine = create(:cuisine, name: 'Brasileira')
    another_cuisine = create(:cuisine, name: 'Italiana')
    visit cuisines_path

    expect(page).to have_content(cuisine.name)
    expect(page).to have_content(another_cuisine.name)
  end

end
