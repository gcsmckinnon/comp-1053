Rails.application.routes.draw do
  resources :users
  resources :card_sort_results
  resources :card_sort_candidates
  resources :card_sorts
  resources :authors
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
