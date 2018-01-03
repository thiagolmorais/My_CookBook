Rails.application.routes.draw do

   root to: 'home#index'
   resources :recipes, only: [:show, :new, :create]

end
