require 'rails_helper'

RSpec.describe RecipesMailer do
  describe 'share' do
    it 'send the correct email' do
      recipe = create(:recipe)

      mail = RecipesMailer.share('amigo@bol.com', 'Olha só essa receita.',
                                 recipe.id)

      expect(mail.to).to include 'amigo@bol.com'
      expect(mail.subject).to eq 'Uma receita foi compartilhada com você'
      expect(mail.from).to include 'no-reply@cookbook.com'
      expect(mail.body).to include 'Olha só essa receita.'
      expect(mail.body).to include recipe_url(recipe)
    end
  end
end
