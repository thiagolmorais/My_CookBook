Rails.application.routes.draw do

  devise_for :users
   root to: 'home#index'
   resources :recipes, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
     collection do
       get 'search'
     end
   end

   resources :cuisines, only: [:index, :show, :new, :create]
   resources :recipe_types, only: [:index, :show, :new, :create]
   resources :favorites, only: [:index, :create]
end
