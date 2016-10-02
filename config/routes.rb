Rails.application.routes.draw do

  resources :qa_options
  resources :qa_questions
  resources :qa_games
  resources :card_sort_results
  resources :card_sorts
  
  root to: 'card_sorts#index'

  get 'getNewQuestion', to: 'qa_games#get_new_question'
  get 'setGameBoard', to: 'qa_games#set_game_board'
  get 'getCurrentQuestion', to: 'qa_games#get_current_question'
  get 'getCurrentQuestionID', to: 'qa_games#get_current_question_id'
  post 'recordAnswer', to: 'qa_games#record_answer'

end
