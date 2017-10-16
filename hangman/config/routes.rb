Rails.application.routes.draw do
  get 'hangman/index'

  resources :games do
    resources :guesses
  end

  root 'hangman#index'
end
