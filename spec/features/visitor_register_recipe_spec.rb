require 'rails_helper'

feature 'Visitor register recipe' do
  scenario 'successfully' do
    # cria os dados necessários
    user = create(:user)
    create(:cuisine, name: 'Arabe')
    create(:recipe_type, name: 'Entrada')

    # simula a ação do usuário
    login_as(user)
    visit root_path
    click_on 'Enviar uma receita'

    fill_in 'Título', with: 'Tabule'
    select 'Arabe', from: 'Cozinha'
    select 'Entrada', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo, cebola, azeite, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione limão.'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Tabule')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Entrada')
    expect(page).to have_css('p', text: 'Arabe')
    expect(page).to have_css('p', text: 'Fácil')
    expect(page).to have_css('p', text: '45 minutos')
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: 'Trigo, cebola, azeite, salsinha')
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text:  'Misturar tudo e servir.')
  end

  scenario 'and must fill in all fields' do
    # cria os dados necessários, nesse caso não vamos criar dados no banco
    user = create(:user)
    create(:cuisine, name: 'Arabe')

    # simula a ação do usuário
    login_as(user)
    visit root_path
    click_on 'Enviar uma receita'

    fill_in 'Título', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar todos os dados da receita')
  end

  scenario 'recipe withe author' do
    # cria os dados necessários, nesse caso não vamos criar dados no banco
    user = create(:user)
    create(:cuisine, name: 'Arabe')
    create(:recipe_type, name: 'Entrada')
    # simula a ação do usuário
    login_as(user)
    visit root_path
    click_on 'Enviar uma receita'
    fill_in 'Título', with: 'Tabule'
    select 'Arabe', from: 'Cozinha'
    select 'Entrada', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo, cebola, azeite, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir.'
    click_on 'Enviar'
    click_on 'Voltar'
    within('div.last_recipes') do
      click_on 'Tabule'
    end

    expect(page).to have_content("Enviada por #{user.username}")
  end

  scenario 'and add photo' do
    user = create(:user)
    create(:cuisine, name: 'Arabe')
    create(:recipe_type, name: 'Entrada')

    login_as(user)
    visit root_path
    click_on 'Enviar uma receita'
    fill_in 'Título', with: 'Tabule'
    select 'Arabe', from: 'Cozinha'
    select 'Entrada', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo, cebola, azeite, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir.'
    attach_file('Imagem', 'spec/support/paperclip/images/tabule.jpg')

    click_on 'Enviar'
    click_on 'Voltar'
    within('div.last_recipes') do
      click_on 'Tabule'
    end

    expect(page).to have_css("img[src*='tabule.jpg']")
  end

  scenario 'and add featured' do
    user = create(:user)
    create(:cuisine, name: 'Arabe')
    create(:recipe_type, name: 'Entrada')

    login_as(user)
    visit root_path
    click_on 'Enviar uma receita'
    fill_in 'Título', with: 'Tabule'
    select 'Arabe', from: 'Cozinha'
    select 'Entrada', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, azeite, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir.'
    check('Destaque')

    click_on 'Enviar'
    visit root_path

    expect(page).to have_css("img[src*='/assets/star-0582542e7338ffe28bc07bcd06e2a047d529743295cb753916c435368db3838b.png']")
  end
end
