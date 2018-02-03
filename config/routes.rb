Rails.application.routes.draw do

  devise_for :users
   root to: 'home#index'
   resources :recipes, only: [:show, :new, :create, :edit, :update, :destroy] do
     collection do
       get 'search'
       get 'favorites'
     end
     member do
       post 'favorite'
       delete 'unfavorite'
       post 'share'
     end
   end

   resources :cuisines, only: [:index, :show, :new, :create, :edit, :update]
   resources :recipe_types, only: [:index, :show, :new, :create, :edit, :update]
end
