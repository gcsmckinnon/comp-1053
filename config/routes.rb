Rails.application.routes.draw do
  
  resources :card_sort_results
  resources :card_sorts
  
  root to: 'card_sorts#index'

end
