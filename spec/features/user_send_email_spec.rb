require 'rails_helper'

feature 'User send email to your friend' do

  scenario 'successfully' do

    recipe = create(:recipe)

    visit recipe_path(recipe)
    fill_in 'Email', with: 'amigo@bol.com'
    fill_in 'Mensagem', with: 'Olha só essa receita.'

    expect(RecipesMailer).to receive(:share).with('amigo@bol.com',
                                                  'Olha só essa receita.',
                                                  recipe.id).and_call_original


    click_on 'Enviar'

    expect(page).to have_content('Email envidado para amigo@bol.com')
    expect(page).to have_current_path(recipe_path(recipe))
  end

end
