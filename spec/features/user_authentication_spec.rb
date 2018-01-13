require 'rails_helper'

feature 'User login' do
  scenario 'sucess' do
    user = User.create(username: 'Thiago', email: 'tf_lima@terra.com.br', password: '123456789')


    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password

    within('div.actions') do
      click_on 'Entrar'
    end

    expect(page).to have_content("Bem-vindo #{user.username}")
    expect(page).not_to have_link('Entrar')

  end

  scenario 'sign out' do
    user = User.create(email: 'tf_lima@terra.com.br', password: '123456789')


    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password

    within('div.actions') do
      click_on 'Entrar'
    end

    visit root_path
    click_on 'Sair'

    expect(page).to have_link('Entrar')

  end


end
