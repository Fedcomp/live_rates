Rails.application.routes.draw do
  root "currencies#index"

  resources :currencies, only: :index do
    # Imitate show with additional param
    get "(/:interval)" => :show,
        on: :member,
        as: "",
        constraints: { interval: /(six_hours|daily|weekly)/ },
        defaults: { interval: "daily" }
  end
end
