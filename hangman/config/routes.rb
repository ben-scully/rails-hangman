Rails.application.routes.draw do

  resources :games do
    resources :guesses
  end

  root 'games#index'
end
