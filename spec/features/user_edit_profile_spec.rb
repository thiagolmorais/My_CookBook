require 'rails_helper'

feature 'User edit your profile' do
  scenario 'successfully' do
    user = create(:user)

    login_as(user)
    visit root_path
    click_on 'Perfil do usuário'

    fill_in 'Nome', with: 'Thiago Fernando'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Facebook', with: 'www.facebook.com'
    fill_in 'Twitter', with: 'www.twitter.com'
    fill_in 'Senha', with: '123456789'
    fill_in 'Confirme sua senha', with: '123456789'
    fill_in 'Senha atual', with: '123456789'
    click_on 'Enviar'
    visit user_path(user.id)

    expect(page).to have_content('Thiago Fernando')
    expect(page).to have_content('São Paulo')
    expect(page).to have_content('www.facebook.com')
    expect(page).to have_content('www.twitter.com')
  end
end
