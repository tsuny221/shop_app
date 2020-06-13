Rails.application.routes.draw do
  get 'market/index'

  resources :goods

  root :to => 'market#index', as: 'market'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
