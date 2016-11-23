Rails.application.routes.draw do
  root "currencies#index"

  resources :currencies, only: [:index, :show]
end
