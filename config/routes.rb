Rails.application.routes.draw do

   root to: 'home#index'
   resources :recipes, only: [:index, :show, :new, :create, :edit, :update] do
     collection do
       get 'search'
     end 
   end

   resources :cuisines, only: [:index, :show, :new, :create]
   resources :recipe_types, only: [:index, :show, :new, :create]
end
